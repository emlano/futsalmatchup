const express = require("express")
const userRouter = require('./routes/users')
const { createLogger, transports } = require('winston')

const port = 3000
const app = express()

const logger = createLogger({
    transports: [new transports.Console]
})

app.use(express.json())
app.use(logRequest)

app.listen(port, () => {
    console.log(`Connected at http://localhost:${port}`)
})

function logRequest(req, res, next) {
    logger.info(req.url)
    next()
}

app.use('/users', userRouter)