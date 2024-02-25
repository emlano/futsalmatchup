const express = require("express");
const router = express.Router();
const db = require("../db");

//Get all bookings
router.get('/', (req, res) => {
    db.getBookings.then(bookings => {
        res.json(bookings);
    })
});
