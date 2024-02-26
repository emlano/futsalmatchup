const express = require("express")
const router = express.Router()
const db = require("../db")
const bcrypt = require("bcrypt")

router.get('/', (req, res) => {
    try {
        db.getUsers().then(users => {
            res.json(users)
        })
    } catch (err) {
        console.error(err)
        res.status(500).send()
    }
})

router.get('/id/:id', (req, res) => {
    try {
        const id = req.params.id

        db.getUserFromId(id).then(user => {
             res.json(user)
        })
    
    } catch (err) {
        console.error(err)
        res.status(500).send()
    }

})

router.get('/name/:username', (req, res) => {
    try {
        const name = req.params.username

        db.getUserFromName(name).then(user => {
            res.json(user)
        })
    } catch (err) {
        console.error(err)
        res.status(500).send()
    }

})

router.post('/', async (req, res) => {
    try {
        const [user] = req.body
        const hashedPass = await bcrypt.hash(user.password, 10)
        user.password = hashedPass

        db.createNewUser(user).then(result => {
            res.json(result)
        })
    
    } catch (err) {
        console.error(err)
        res.status(500).send()
    }

})

router.put('/', (req, res) => {
    try {
        const [user] = req.body
        db.updateUser(user).then(result => {
            res.send()
        })
    
    } catch (err) {
        console.error(err)
        res.status(500).send()
    }
})

router.delete('/id/:id', (req, res) => {
    try {
        const id = req.params.id

        db.deleteUser(id).then(result => {
            res.send()
        })

    } catch (err) {
        console.error(err)
        res.status(500).send()
    }
})

module.exports = router