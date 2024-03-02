const express = require("express")
const userRouter = require('./routes/users')
const bookingRouter = require('./routes/bookings'); 
const { createLogger, transports } = require('winston');

const app = express()

const logger = createLogger({
    transports: [new transports.Console]
})

app.use(express.json())
app.use(logRequest)

function logRequest(req, res, next) {
    logger.info(`${req.method} - ${req.url}`)
    next()
}

app.use('/users', userRouter);
app.use('/bookings', bookingRouter); 

module.exports = app