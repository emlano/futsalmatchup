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

   db.getUserFromId(id).then(user => {
        res.json(user)
   })
})

router.get('/name/:username', (req, res) => {
    const name = req.params.username

    db.getUserFromName(name).then(user => {
        res.json(user)
    })
})

router.post('/', (req, res) => {
    const result = db.createNewUser(req.body)
    
    res.json(result)
})

module.exports = router