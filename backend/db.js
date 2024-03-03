const mysql = require("mysql2")
const { exceptions } = require("winston")
const DuplicateUsername = require("./errors/duplicateUser")

const pool = mysql.createPool({
    host: process.env.HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE
}).promise()

async function getUsers() {
    try {
        const [rows] = await pool.query("SELECT * FROM `players`;")
        return rows
    } catch (err) {

    }
}

async function getUserFromId(id) {
    const [rows] = await pool.query(`
        SELECT
            user_id,
            username,
            player_skill_rating,
            player_sportsmanship_rating,
            player_overall_rating,
            player_city,
            player_availability,
            player_position,
            team_id
        FROM players 
        WHERE user_id = ?;`,
        [id])

    return rows
}

async function getUserFromName(name) {
    const [rows] = await pool.query(`
        SELECT
            user_id,
            username,
            player_skill_rating,
            player_sportsmanship_rating,
            player_overall_rating,
            player_city,
            player_availability,
            player_position,
            team_id
        FROM players
        WHERE username 
        LIKE ?;`,
        [name])

    return rows
}

async function createNewUser(user) {
    const username = user.username
    const password = user.password
    const phoneNo = user.phone_no
    
    const [duplicates] = await pool.query(`
    SELECT * FROM players WHERE username LIKE ?;
    `, [username])
    
    if (!duplicates != []) throw new DuplicateUsername()

    const [result] = await pool.query(`
        INSERT INTO players (
            username, 
            password, 
            phone_no, 
            player_skill_rating, 
            player_sportsmanship_rating, 
            player_overall_rating,
            player_availability
        )
        VALUES
        (?, ?, ?, ?, ?, ?, ?);`, 
        [username, password, phoneNo, 3.5, 3.5, 3.5, true])
    
    return getUserFromName(username)
}

async function updateUser(user, id) {
    const skillRating = user.player_skill_rating
    const sportsmanship = user.player_sportsmanship_rating
    const overallRating = user.player_overall_rating
    const city = user.player_city
    const availability = user.player_availability
    const position = user.player_position
    const teamId = user.team_id

    if (skillRating != null) {
        result = await pool.query(`
            UPDATE players
            SET player_skill_rating = ?
            WHERE user_id = ? ;`,
        [skillRating, id])
    }

    if (sportsmanship != null) {
        result = await pool.query(`
            UPDATE players
            SET player_sportsmanship_rating = ?
            WHERE user_id = ? ;`,
        [sportsmanship, id])
    }

    if (overallRating != null) {
        result = await pool.query(`
            UPDATE players
            SET player_overall_rating = ?
            WHERE user_id = ? ;`,
        [overallRating, id])
    }

    if (city != null) {
        result = await pool.query(`
            UPDATE players
            SET player_city = ?
            WHERE user_id = ? ;`,
        [city, id])
    }

    if (availability != null) {
        result = await pool.query(`
            UPDATE players
            SET player_availability = ?
            WHERE user_id = ? ;`,
        [availability, id])
    }

    if (position != null) {
        result = await pool.query(`
            UPDATE players
            SET player_position = ?
            WHERE user_id = ? ;`,
        [position, id])
    }

    if (teamId != null) {
        result = await pool.query(`
            UPDATE players
            SET team_id = ?
            WHERE user_id = ? ;`,
        [teamId, id])
    }

    return result
}

async function deleteUser(id) {
    const [result] = await pool.query(`
        DELETE FROM players
        WHERE user_id = ?`,
        [id])

    return result
}

async function getBookings() {
    const [rows] = await pool.query("SELECT * FROM `bookings`;");
    return rows;
}

async function getBookingFromId(id) {
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
    getUsers,
    getUserFromId,
    getUserFromName,
    createNewUser,
    updateUser,
    deleteUser,
    getBookings,
    getBookingFromId,
    createNewBooking,
    updateBooking,
    deleteBooking
}