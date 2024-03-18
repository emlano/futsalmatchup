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
router.get("/:teamId", authenticateToken, (req, res) => {
  try {
    const userId = req.user_id;
    const teamId = req.params.teamId;

    // Fetch team details including its members
    db.getTeamDetails(teamId).then((team) => {
      if (!team) {
        res.status(404).send({ error: "Team not found" });
      } else {
        // Filter team members to include only the logged-in user's name
        const user = team.members.find(member => member.id === userId);
        if (!user) {
          res.status(404).send({ error: "User not found in the team" });
        } else {
          const teamRoster = [{ "name": user.name, "profilePicUrl": user.profilePicUrl }];
          res.send(teamRoster);
        }
      }
    });
  } catch (err) {
    console.error(err);
    res.status(500).send({ error: "Internal server error" });
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

    db.createNewTeam(teamData).then(result => {
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
