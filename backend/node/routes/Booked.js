const express = require("express");
const router = express.Router();
const db = require("../db");
const { authenticateToken } = require("../middleware/auth");

router.get("/", (req, res) => {
  try {
    db.getBooked().then((Booked) => {
      res.json(Booked);
    });
  } catch (err) {
    console.error(err);
    res.status(500).send();
  }
});
