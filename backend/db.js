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
        WHERE user_id = ${id}
    `)

    return rows
}

async function getUserFromName(name) {
    const [rows] = await pool.query(`
        SELECT * 
        FROM players
        WHERE username LIKE '${name}'
    `)

    return rows
}

async function createNewUser(user) {
    const username = user.username
    const password = user.password
    const phoneNo = user.phoneNo

    const [result] = await pool.query(`
        INSERT INTO players
        (username, password, phone_no)
        VALUES
        (?, ?, ?)`, 
        [username, password, phoneNo])

    return result
}

module.exports.getUsers = getUsers
module.exports.getUserFromId = getUserFromId
module.exports.getUserFromName = getUserFromName
module.exports.createNewUser = createNewUser