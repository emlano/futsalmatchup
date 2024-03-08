const express = require("express");
const router = express.Router();
const db = require("../db");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const DuplicateUsername = require("../errors/duplicateUser");

// router.get('/', (req, res) => {      /// Unused since no auth needed / Could be used to send all users info to python server
//     try {
//         db.getUsers().then(users => {
//             res.json(users)
//         })
//     } catch (err) {
//         console.error(err)
//         res.status(500).send()
//     }
// })

router.get("/", authenticateToken, (req, res) => {
  try {
    const id = req.user_id;

    db.getUserFromId(id).then((user) => {
      if (user.length == 0) res.status(404).send({ error: "user not found" });
      else res.send(user);
    });
  } catch (err) {
    console.error(err);
    res.status(500).send({ error: "internal server error" });
  }
});

router.get("/other", authenticateToken, async (req, res) => {
  try {
    if (!req.body || Object.keys(req.body).length == 0) {
      res.status(400).send({ error: "required arguments not given" });
      return;
    }

    const [other] = req.body;

    if (other.id != null) {
      await db.getUserFromId(other.id).then((user) => {
        if (user.length == 0) res.status(404).send({ error: "user not found" });
        else res.send(user);
      });
    } else if (other.username != null) {
      await db.getUserFromName(other.username).then((user) => {
        if (user.length == 0) res.status(404).send({ error: "user not found" });
        else res.send(user);
      });
    } else {
      res
        .status(400)
        .send({ error: "requested users id or username not given" });
    }
  } catch (err) {
    console.error(err);
    res.status(500).send({ error: "internal server error" });
  }
});

router.post("/signup", async (req, res) => {
  try {
    if (!req.body || Object.keys(req.body).length == 0) {
      res.status(400).send({ error: "required arguments not given" });
      return;
    }

    const [candidate] = req.body;

    if (candidate.password == null || candidate.username == null) {
      res.status(400).send({ error: "username or password not given" });
      return;
    }

    const hashedPass = await bcrypt.hash(candidate.password, 10);
    candidate.password = hashedPass;

    const result = await db.createNewUser(candidate);
    const [user] = result;
    const accessToken = jwt.sign(user, process.env.ACCESS_TOKEN_SECRET, {
      expiresIn: 60 * 60,
    });
    res.send({ accessToken: accessToken });
  } catch (err) {
    if (err instanceof DuplicateUsername) {
      res.status(409).send({ error: "username already taken" });
      return;
    }

    console.error(err);
    res.status(500).send({ error: "internal server error" });
  }
});

router.post("/login", async (req, res) => {
  try {
    if (!req.body || Object.keys(req.body).length == 0) {
      res.status(400).send({ error: "required arguments not given" });
      return;
    }

    const [candidate] = req.body;
    const [user] = await db.getUserFromNameWithPassword(candidate.username);

    if (user == null) {
      return res.status(404).send({ error: "no such user found" });
    }

    hashedUsername = await bcrypt.hash(user.username, 10);

    if (
      (await bcrypt.compare(candidate.password, user.password)) &&
      (await bcrypt.compare(candidate.username, hashedUsername))
    ) {
      const accessToken = jwt.sign(user, process.env.ACCESS_TOKEN_SECRET, {
        expiresIn: 60 * 60,
      });
      res.send({ accessToken: accessToken });
    } else {
      res.status(401).send({ error: "username or password is incorrect" });
    }
  } catch (err) {
    console.error(err);
    res.status(500).send({ error: "internal server error" });
  }
});

router.put("/", authenticateToken, async (req, res) => {
  try {
    if (!req.body || Object.keys(req.body).length == 0) {
      res.status(400).send({ error: "required arguments not given" });
      return;
    }

    const [fieldsToUpdate] = req.body;
    const id = req.user_id;

    await db.updateUser(fieldsToUpdate, id);
    res.send({ status: "success" });
  } catch (err) {
    console.error(err);
    res.status(500).send({ error: "internal server error" });
  }
});

router.delete("/", authenticateToken, async (req, res) => {
  try {
    const id = req.user_id;

    await db.deleteUser(id);
    res.send({ status: "success" });
  } catch (err) {
    console.error(err);
    res.status(500).send({ error: "internal server error" });
  }
});

// middleware for user authentication
function authenticateToken(req, res, next) {
  const header = req.headers["authorization"];
  const token = header && header.split(" ")[1];

  if (token == null)
    return res.status(401).send({ error: "no authorization token given" });

  jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, user) => {
    if (err)
      return res.status(403).send({ error: "malformed or expired token" });

    req.user_id = user.user_id;
    next();
  });
}

module.exports = router;
