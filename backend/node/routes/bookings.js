const express = require("express");
const router = express.Router();
const db = require("../db");

// Route to get all bookings
router.get("/", (req, res) => {

  // Retrieve all bookings from the database
  db.getBookings().then((bookings) => {
    res.json(bookings); // Respond with JSON containing all bookings
  });
});

// Route to get a booking by its ID
router.get("/:id", (req, res) => {
  const id = req.params.id;

  // Retrieve booking with specified ID from the database
  db.getBookingFromId(id).then((bookings) => {
    res.json(bookings); // Respond with JSON containing the booking
  });
});

// Route to create a new booking
router.post("/", (req, res) => {

   // Extract booking data from the request body
  const bookings = req.body;

  // Create a new booking in the database
  db.createNewBooking(bookings).then((result) => {
    res.json(result); // Respond with JSON containing the result of the post method
  });
});


// Route to update a booking by its ID
router.put("/:id", (req, res) => {
  const id = req.params.id;

  // Extract updated booking data from the request body
  const updatedBooking = req.body;

  // Update the booking with specified ID in the database
  db.updateBooking(id, updatedBooking).then((result) => {
    res.json(result); // Respond with JSON containing the result of the put method
  });
});

// Route to delete a booking by its ID
router.delete("/:id", (req, res) => {
  const id = req.params.id;

  // Delete the booking with specified ID from the database
  db.deleteBooking(id).then((result) => {
    res.json(result); // Respond with JSON containing the result of the operation
  });
});

module.exports = router;
