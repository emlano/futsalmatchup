const express = require("express")
const router = express.Router()
const db = require("../db")

router.get('/', (req, res) => {
    db.getUsers().then(users => {
        res.json(users)
    })
})

router.get('/id/:id', (req, res) => {
    const id = req.params.id

   db.getUser(id).then(user => {
        res.json(user)
   })
})

router.get('/name/:username', (req, res) => {
    const name = req.params.username

    db.getUserByName(name).then(user => {
        res.json(user)
    })
})

module.exports = router