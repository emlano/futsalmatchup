require("dotenv").config()
const express = require("express")
const mysql = require("mysql2")

const port = 3000

const app = express()
app.use(express.json())

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

app.listen(port, () => {
    console.log(`Connected at http://localhost:${port}`)
})

const userRouter = require('./routes/users')


app.get('/users', (req, res) => {
    getUsers().then(x => {
        res.json(x)
    })
})