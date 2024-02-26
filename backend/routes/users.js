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

router.post('/login',async (req, res) => {
    const [candidate] = req.body
    const [user] = await db.getUserFromName(candidate.username)

    if (user == null) {
        return res.status(400).send("No such user found")
    }

    try {
        if (await bcrypt.compare(candidate.password, user.password)) {
            res.send("Success")
        } else {
            res.send("Failure")
        }
    
    } catch (err) {
        res.status(500).send()
    }
})

router.put('/', (req, res) => {
    try {
        const [user] = req.body
        db.updateUser(user).then(() => {
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

        db.deleteUser(id).then(() => {
            res.send()
        })

    } catch (err) {
        console.error(err)
        res.status(500).send()
    }
})

module.exports = router