const express = require("express");
const router = express.Router();
const db = require("../db");

//Get all bookings
router.get('/', (req, res) => {
    db.getBookings().then(bookings => {
        res.json(bookings);
    })
});

//Get booking by id
router.get('/:id', (req, res) => {
    const id = req.params.id;
    db.getBookingFromId(id).then(bookings => {
        res.json(bookings)
   })
});

//Create a new booking
router.post('/', (req, res) => {
    const [bookings] = req.body
    
    db.createNewBooking(bookings).then(result => {
        res.json(result)
    })
})
// Update booking by id
router.put('/:id', (req, res) => {
    const id = req.params.id;
    const updatedBooking = req.body;

    db.updateBooking(id, updatedBooking).then(result => {
        res.json(result);
    });
});

// Delete booking by id
router.delete('/:id', (req, res) => {
    const id = req.params.id;

    db.deleteBooking(id).then(result => {
        res.json(result);
    });
});

module.exports = router;