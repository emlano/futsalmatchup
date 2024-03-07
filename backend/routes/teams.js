const express = require("express");
const router = express.Router();
const db = require("../db");

// Get all teams
router.get("/", (req, res) => {
  db.getTeams().then((teams) => {
    res.json(teams);
  });
});

// Get team by id
router.get("/:id", (req, res) => {
  const id = req.params.id;
  db.getTeamFromId(id).then((teams) => {
    res.json(teams);
  });
});

// Create a new team
router.post("/", (req, res) => {
  const newTeam = req.body;

  db.createNewTeam(newTeam).then((result) => {
    res.json(result);
  });
});

// Update team by id
router.put("/:id", (req, res) => {
  const id = req.params.id;
  const updatedTeam = req.body;

  db.updateTeam(id, updatedTeam).then((result) => {
    res.json(result);
  });
});

// Delete team by id
router.delete("/:id", (req, res) => {
  const id = req.params.id;

  db.deleteTeam(id).then((result) => {
    res.json(result);
  });
});

module.exports = router;
