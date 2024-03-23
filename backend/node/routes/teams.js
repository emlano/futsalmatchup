const express = require("express");
const router = express.Router();
const db = require("../db");
const { authenticateToken } = require("../middleware/auth");

router.get("/", (req, res) => {
  try {
    db.getTeams().then((teams) => {
      res.json(teams);
    });
  } catch (err) {
    console.error(err);
    res.status(500).send();
  }
});

//Get team by id
router.get("/:id", (req, res) => {
  try {
    const id = req.params.id;
    db.getTeamFromId(id).then((teams) => {
      if (teams == null) {
        res.status(404).send({ error: "team not found" });
      } else {
        res.send(teams);
      }
    });
  } catch (err) {
    console.error(err);
    res.status(500).send();
  }
});

//Create a new team
router.post("/", authenticateToken, async (req, res) => {
  try {
    if (!req.body || Object.keys(req.body).length != 1) {
      res.status(400).send({ error: "missing arguments or malformed request" });
      return;
    }

    const [teamData] = req.body;
    const newTeam = await db.createNewTeam(teamData);

    db.createNewTeam(teamData).then((result) => {
      res.json(result);
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

// Update team by id
router.put("/:id", authenticateToken, (req, res) => {
  try {
    const id = req.params.id;
    const updatedTeams = req.body;

    db.updateTeam(id, updatedTeams).then((result) => {
      res.json(result);
    });
  } catch (err) {
    console.error(err);
    res.status(500).send();
  }
});

// Delete team by id
router.delete("/:id", authenticateToken, (req, res) => {
  try {
    const id = req.params.id;

    db.deleteTeam(id).then((result) => {
      res.json(result);
    });
  } catch (err) {
    console.error(err);
    res.status(500).send();
  }
});

module.exports = router;
