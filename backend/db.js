require("dotenv").config();
const mysql = require("mysql2");

const pool = mysql.createPool({
    host: process.env.HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE
}).promise();

async function getBookings() {
    try{
        const [rows] = await pool.query("SELECT * FROM `bookings`;");
        return rows;
    }
    catch(error) {
        throw error;
    }
}

async function getBookingFromId() {
    const [rows] = await pool.query(`
    SELECT * 
    FROM bookings 
    WHERE booking_id = ?;`,
    [id])

    return rows;
}

async function createNewBooking(booking) {
    const { stadium_id, team_id, user_id, start_date_time, end_date_time } = booking;
    const [result] = await pool.query(`
        INSERT INTO bookings (stadium_id, team_id, user_id, start_date_time, end_date_time) 
        VALUES (?, ?, ?, ?, ?);`,
        [stadium_id, team_id, user_id, start_date_time, end_date_time]);
    return result;
}
async function updateBooking(bookingId, updatedBooking) {
    const { stadium_id, team_id, user_id, start_date_time, end_date_time } = updatedBooking;

    const [result] = await pool.query(`
        UPDATE bookings
        SET
            stadium_id = ?,
            team_id = ?,
            user_id = ?,
            start_date_time = ?,
            end_date_time = ?
        WHERE booking_id = ?;`,
        [stadium_id, team_id, user_id, start_date_time, end_date_time, bookingId]);

    return result;
}
async function deleteBooking(bookingId) {
    const [result] = await pool.query(`
        DELETE FROM bookings
        WHERE booking_id = ?`,
        [bookingId]);

    return result;
}
module.exports = { 
    getBookings,
    getBookingFromId,
    createNewBooking,
    updateBooking,
    deleteBooking
};