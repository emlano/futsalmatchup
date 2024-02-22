require("dotenv").config()
const mysql = require("mysql2")

const pool = mysql.createPool({
    host: process.env.HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE
}).promise()

async function getUsers() {
    const [rows] = await pool.query("SELECT * FROM `players`;")
    return rows
}

async function getUserFromId(id) {
    const [rows] = await pool.query(`
        SELECT * 
        FROM players 
        WHERE user_id = ?;`,
        [id])

    return rows
}

async function getUserFromName(name) {
    const [rows] = await pool.query(`
        SELECT * 
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

    return result
}

async function updateUser(user) {
    const userId = user.user_id
    const skillRating = user.player_skill_rating
    const sportsmanship = user.player_sportsmanship_rating
    const overallRating = user.player_overall_rating
    const city = user.player_city
    const availability = user.player_availability
    const position = user.player_position
    const teamId = user.team_id

    const [result] = await pool.query(`
        UPDATE players
        SET
            player_skill_rating = ?,
            player_sportsmanship_rating = ?,
            player_overall_rating = ?,
            player_city = ?,
            player_availability = ?,
            player_position = ?,
            team_id = ?
        WHERE user_id = ? ;`,
        [skillRating, sportsmanship, overallRating, city, availability, position, teamId, userId])

    return result
}

async function deleteUser(id) {
    const [result] = await pool.query(`
        DELETE FROM players
        WHERE user_id = ?`,
        [id])

    return result
}

module.exports = { 
    getUsers,
    getUserFromId,
    getUserFromName,
    createNewUser,
    updateUser,
    deleteUser
 }