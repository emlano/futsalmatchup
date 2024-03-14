const express = require("express");
const router = express.Router();
const db = require("../db");
<<<<<<< HEAD
<<<<<<< HEAD
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const DuplicateTeamName = require("../errors/duplicateTeams");
const { authenticateToken } = require("../middleware/auth");
=======
const { authenticateToken } = require("../middleware/auth");
const DuplicateTeamName = require("../errors/duplicateTeams");
>>>>>>> b24f2f4 (changes made in backend but not completed)
=======
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const DuplicateTeamName = require("../errors/duplicateTeams");
const { authenticateToken } = require("../middleware/auth");
>>>>>>> 8523146 (changes on node testing)

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
      res.json(teams);
    });
  } catch (err) {
    console.error(err);
    res.status(500).send();
  }
});

//Create a new team
router.post("/", authenticateToken, async (req, res) => {
  try {
    const team = req.body;
    const newTeam = await db.createNewTeam(teamData);

    db.createNewTeam(teams).then((result) => {
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
