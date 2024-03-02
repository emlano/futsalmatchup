const express = require("express")
const router = express.Router()
const db = require("../db")
const bcrypt = require("bcrypt")
const jwt = require("jsonwebtoken")
const errors = require("../errors/duplicateUser")
const DuplicateUsername = require("../errors/duplicateUser")
const MissingArguments = require("../errors/missingArgs")

// router.get('/', (req, res) => {      /// Unused since no auth needed / Could be used to send all users info to python server
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
        console.error("Error: " + err)
        res.status(500).send({ error: "Internal server error" })
    }
})

router.post('/signup', async (req, res) => {
    try {
        const [user] = req.body
        if (user.password == null || user.username == null) res.statusCode(400).send({ error: "Username or password not given"} )
        
        const hashedPass = await bcrypt.hash(user.password, 10)
        user.password = hashedPass
        
        db.createNewUser(user).then(result => {
            const [user] = result
            const accessToken = jwt.sign(user, process.env.ACCESS_TOKEN_SECRET)
            res.send({ accessToken: accessToken })
            
        }).catch(err => {
            if (err instanceof DuplicateUsername) res.status(409).send({ error: "Username already taken" })
            else throw err
        })
    
    } catch (err) {
        console.error("Error: " + err.message)
        res.status(500).send({ error: "Internal server error" })
    }
})

router.post('/login',async (req, res) => {
    const [candidate] = req.body
    const [user] = await db.getUserFromName(candidate.username)

    if (user == null) {
        return res.status(404).send({ error: "No such user found" })
    }

    try {
        if (await bcrypt.compare(candidate.password, user.password)) {
            const accessToken = jwt.sign(user, process.env.ACCESS_TOKEN_SECRET)
            res.send({ accessToken: accessToken })


        } else {
            res.status(401).send({ error: "Username or password is wrong" })
        }
    
    } catch (err) {
        console.error("Error: " + err.message)
        res.status(500).send({ error: "Internal server error" })
    }
})

router.put('/', authenticateToken, (req, res) => {
    try {
        const [updatedUser] = req.body
        const id = req.user_id

        db.updateUser(updatedUser, id).then(() => {
            res.send()
        })
        .catch(err => {
            if (err instanceof MissingArguments) res.status(400).send({ error: "Request missing data arguments" })
        }) 
    
    } catch (err) {
        console.error("Error: " + err.message)
        res.status(500).send({ error: "Internal server error" })
    }
})

router.delete('/', authenticateToken, (req, res) => {
    try {
        const id = req.user_id

        db.deleteUser(id).then(() => {
            res.send()
        })

    } catch (err) {
        console.error("Error: " + err.message)
        res.status(500).send({ error: "Internal server error" })
    }
})

function authenticateToken(req, res, next) {
    const header = req.headers['authorization']
    const token = header && header.split(' ')[1]

    if (token == null) return res.status(401).send({ error: "No authetication token given" })

    jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, user) => {
        if (err) return res.status(403).send({ error: "Malformed or incorrect token" })

        req.user_id = user.user_id
        next()
    })
}

module.exports = router