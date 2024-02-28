// require("dotenv").config()

const express = require("express")
const router = express.Router()
const db = require("../db")
const bcrypt = require("bcrypt")
const jwt = require("jsonwebtoken")

// router.get('/', (req, res) => {      /// Unused since no auth needed
//     try {
//         db.getUsers().then(users => {
//             res.json(users)
//         })
//     } catch (err) {
//         console.error(err)
//         res.status(500).send()
//     }
// })

router.get('/', authenticateToken, (req, res) => {
    try {
        const id = req.user_id

        db.getUserFromId(id).then(user => {
             res.json(user)
        })
    
    } catch (err) {
        console.error(err)
        res.status(500).send()
    }

})

// router.get('/name/:username', (req, res) => {   // Unneccesary
//     try {
//         const name = req.params.username

//         db.getUserFromName(name).then(user => {
//             res.json(user)
//         })
//     } catch (err) {
//         console.error(err)
//         res.status(500).send()
//     }

// })

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

    console.log(user)

    if (user == null) {
        return res.status(404).send("No such user found")
    }

    try {
        if (await bcrypt.compare(candidate.password, user.password)) {
            const accessToken = jwt.sign(user, process.env.ACCESS_TOKEN_SECRET)
            res.json({ accessToken: accessToken })

        } else {
            res.status(401).send()
        }
    
    } catch (err) {
        res.status(500).send()
    }
})


router.put('/', authenticateToken, (req, res) => {
    try {
        const [updatedUser] = req.body
        const id = req.user_id

        db.updateUser(updatedUser, id).then(() => {
            res.send()
        })
    
    } catch (err) {
        console.error(err)
        res.status(500).send()
    }
})

router.delete('/', authenticateToken, (req, res) => {
    try {
        const id = req.user_id

        db.deleteUser(id).then(() => {
            res.send()
        })

    } catch (err) {
        console.error(err)
        res.status(500).send()
    }
})

function authenticateToken(req, res, next) {
    const header = req.headers['authorization']
    const token = header && header.split(' ')[1]

    if (token == null) return res.status(401).send()

    jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, user) => {
        if (err) return res.status(403).send()

        req.user_id = user.user_id
        next()
    })
} 

module.exports = router