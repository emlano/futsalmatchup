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

async function getUser(id) {
    const [rows] = await pool.query(`
        SELECT * 
        FROM players 
        WHERE user_id = ${id}
    `)

    return rows
}

async function getUserByName(name) {
    const [rows] = await pool.query(`
        SELECT * 
        FROM players
        WHERE username LIKE '${name}'
    `)

    return rows
}

module.exports.getUsers = getUsers
module.exports.getUser = getUser
module.exports.getUserByName = getUserByName