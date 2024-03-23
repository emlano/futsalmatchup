const express = require("express");
const router = express.Router();
const db = require("../db"); // Importing the database functions

//Get all bookings
router.get("/", (req, res) => {
  // Retrieve all bookings from the database
  db.getBookings().then((bookings) => {
    // Send the retrieved bookings as a JSON response
    res.json(bookings);
  });
});

//Get booking by id
router.get("/:id", (req, res) => {
  const id = req.params.id; // Extract the booking ID from request parameters
  // Retrieve the booking with the specified ID from the database
  db.getBookingFromId(id).then((booking) => {
    // If booking is not found, return a 404 status with an error message
    if (!booking) {
      return res.status(404).json({ error: "Booking not found" });
    }
    // Send the retrieved booking as a JSON response
    res.json(booking);
  });
});


//Create a new booking
router.post("/", (req, res) => {
  const bookings = req.body; // Extract the booking details from request body
 // Insert the new booking into the database
  db.createNewBooking(bookings).then((result) => {
    res.json(result);
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