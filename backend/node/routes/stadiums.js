const express = require("express");
const router = express.Router();
const db = require("../../db");
const authenticateToken = require("../node/middleware/authenticateToken");

router.get("/", authenticateToken, (req, res) => {
  try {
    db.getStadiums().then((stadiums) => {
      res.json(stadiums);
    });
  } catch (err) {
    console.error(err);
    res.status(500).send();
  }
});

router.post("/", authenticateToken, async (req, res) => {
  try {
    const [stadium] = req.body;

    db.createStadium(stadium).then((result) => {
      res.json(result);
    });
  } catch (err) {
    console.error(err);
    res.status(500).send();
  }
});

router.put("/", authenticateToken, (req, res) => {
  try {
    const [updatedStadium] = req.body;
    const id = updatedStadium.stadium_id;

    db.updateStadium(updatedStadium, id).then(() => {
      res.send();
    });
  } catch (err) {
    console.error(err);
    res.status(500).send();
  }
});

router.delete("/", authenticateToken, (req, res) => {
  try {
    const id = req.query.stadium_id;

    db.deleteStadium(id).then(() => {
      res.send();
    });
  } catch (err) {
    console.error(err);
    res.status(500).send();
  }
});

module.exports = router;
