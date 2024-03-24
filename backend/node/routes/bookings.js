const express = require("express");
const router = express.Router();
const db = require("../db"); // Importing the database functions

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

// Update booking by id
router.put("/:id", (req, res) => {
  const id = req.params.id; // Extract the booking ID from request parameters
  const updatedBooking = req.body; // Extract the updated booking details from request body

  // Update the booking with the specified ID in the database
  db.updateBooking(id, updatedBooking)
    .then((result) => {
      // Send the result of the update operation as a JSON response
      res.json(result);
    })
    .catch((error) => {
      // If an error during update, return a 500 status with an error message
      res.status(500).json({ error: "Error updating booking" });
    });
});

// Delete booking by id
router.delete("/:id", (req, res) => {
  const id = req.params.id;
  // Delete the booking with the specified ID from the database
  db.deleteBooking(id)
    .then((result) => {
      // If booking is not found, return a 404 status with an error message
      if (!result) {
        return res.status(404).json({ error: "Booking not found" });
      }
      // Send the result of the deletion as a JSON response
      res.json(result);
    })
    .catch((error) => {
    // If an error during deletion, return a 500 status with an error message
      res.status(500).json({ error: "Error deleting booking" });
    });
});

module.exports = router;



     