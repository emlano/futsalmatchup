const express = require("express");
const router = express.Router();
const db = require("../db");
const { authenticateToken } = require("../middleware/auth");
const DuplicateTeamName = require("../errors/duplicateTeams");

// Get all teams
router.get("/", authenticateToken, (req, res) => {
  db.getTeams().then((teams) => {
    res.json(teams);
  });
});

// Get team by id
router.get("/:id", authenticateToken, (req, res) => {
  const id = req.params.id;
  db.getTeamFromId(id).then((team) => {
    if (team.length === 0) {
      res.status(404).json({ error: "Team not found" });
    } else {
      res.json(team);
    }
  });
});

// Create a new team
router.post("/", authenticateToken, (req, res) => {
  const newTeam = req.body;

  db.createNewTeam(newTeam).then((result) => {
    res.json(result);
  });
});

// Update team by id
router.put("/:id", authenticateToken, (req, res) => {
  const id = req.params.id;
  const updatedTeam = req.body;

  db.updateTeam(id, updatedTeam).then((result) => {
    if (result.affectedRows === 0) {
      res.status(404).json({ error: "Team not found" });
    } else {
      res.json(result);
    }
  });
});

// Delete team by id
router.delete("/:id", authenticateToken, (req, res) => {
  const id = req.params.id;

  db.deleteTeam(id).then((result) => {
    if (result.affectedRows === 0) {
      res.status(404).json({ error: "Team not found" });
    } else {
      res.json(result);
    }
  });
});

module.exports = router;
