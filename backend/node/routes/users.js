const express = require("express");
const router = express.Router();
const db = require("../db");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const DuplicateUsername = require("../errors/duplicateUser");
const { authenticateToken } = require("../middleware/auth");

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
    if (!req.body || Object.keys(req.body).length != 1) {
      res.status(400).send({ error: "missing arguments or malformed request" });
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
    if (!req.body || Object.keys(req.body).length != 1) {
      res.status(400).send({ error: "missing arguments or malformed request" });
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
      expiresIn: '30d',
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
    if (!req.body || Object.keys(req.body).length != 1) {
      res.status(400).send({ error: "missing arguments or malformed request" });
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
        expiresIn: '30d',
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

router.post("/recommend", authenticateToken, async (req, res) => {
  try {
    const [target] = await db.getUserFromId(req.user_id);
    const payload = await db.getAllUsersExcept(req.user_id);

    payload.unshift(target);

    const response = await fetch('http://localhost:8080', {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(payload)
    })

    const result = JSON.parse(await response.text());
    res.status(405).send(result);
  
  } catch (e) {
    res.status(500).send({ error: "internal server error" });
    console.error(e);
  }
})

router.put("/", authenticateToken, async (req, res) => {
  try {
    if (!req.body || Object.keys(req.body).length != 1) {
      res.status(400).send({ error: "missing arguments or malformed request" });
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

module.exports = router;