const request = require("supertest")
const app = require("../app")
const db = require("../db")
const jwt  = require("jsonwebtoken")

jest.mock("../db", () => ({
    getBookings: jest.fn(),
    getBookingFromId: jest.fn(),
    createNewBooking: jest.fn(),
    updateBooking: jest.fn(),
    deleteBooking: jest.fn(),
}))

describe("GET /bookings", () => {
    test("should return all bookings", async () => {
        const mockBookings = [{ id: 1, name: "Booking 1" }, { id: 2, name: "Booking 2" }];
        db.getBookings.mockResolvedValue(mockBookings);
        const response = await request(app).get("/bookings");
        expect(response.status).toBe(200);
        expect(response.body).toEqual(mockBookings);


    });
});

describe("GET /bookings/:id", () => {
    test("should return booking with given id", async () => {
      const mockBooking = { id: 1, name: "Booking 1" };
      db.getBookingFromId.mockResolvedValue(mockBooking);
      const response = await request(app).get("/bookings/1");
      expect(response.status).toBe(200);
      expect(response.body).toEqual(mockBooking);
    });
  
    test("should return 404 if booking with given id is not found", async () => {
      db.getBookingFromId.mockResolvedValue(null);
      const response = await request(app).get("/bookings/999");
      expect(response.status).toBe(404);
    });

   
  });
  

  // Test block for updating a booking by id
  describe("PUT /bookings/:id", () => {
    // Test case for updating an existing booking
    test("should update a booking by id", async () => {
      const updatedBooking = { id: 1, name: "Updated Booking 1" };
      db.updateBooking.mockResolvedValue(updatedBooking);
  
      const response = await request(app)
        .put("/bookings/1")
        .send(updatedBooking);
  
      expect(response.status).toBe(200);
      expect(response.body).toEqual(updatedBooking);
    });
  
    // Test case for handling errors during update
    test("should handle errors when updating a booking by id", async () => {
      const updatedBookingData = { team_id: 2, user_id: 3, start_date_time: "2024-03-11 16:00:00", end_date_time: "2024-03-11 17:00:00" };
      db.updateBooking.mockRejectedValue(new Error("Database error"));
  
      const response = await request(app)
        .put("/bookings/1")
        .send({ id: 1, name: "Updated Booking 1" });
  
      expect(response.status).toBe(500);
    });
  });
  
  // Test block for deleting a booking by id
  describe("DELETE /bookings/:id", () => {
    // Test case for deleting a booking
    test("should delete a booking by id", async () => {
      const deletedBooking = { id: 1, name: "Booking 1" };
      db.deleteBooking.mockResolvedValue(deletedBooking);

      const response = await request(app).delete("/bookings/1");

      expect(response.status).toBe(200);
      expect(response.body).toEqual(deletedBooking);
    });

    // Test case for handling errors during deletion
    test("should handle errors when deleting a booking by id", async () => {
      db.deleteBooking.mockRejectedValue(new Error("Database error"));
  
      const response = await request(app).delete("/bookings/1");
  
      expect(response.status).toBe(500);
    });

    // Test case for returning 404 if booking with given id is not found
    test("should return 404 if booking with given id is not found", async () => {
      db.deleteBooking.mockResolvedValue(null);

      const response = await request(app).delete("/bookings/999");

      expect(response.status).toBe(404);
    });
  });

