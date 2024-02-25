require("dotenv").config();
const mysql = require("mysql2");

const pool = mysql.createPool({
    host: process.env.HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE
}).promise();

async function getBookings() {
    const [rows] = await pool.query("SELECT * FROM `bookings`;");
    return rows;
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