const express = require("express");
const bookingRouter = require('./routes/bookings'); 
const { createLogger, transports } = require('winston');

const port = 3000;
const app = express();

const logger = createLogger({
    transports: [new transports.Console()]
});

app.use(express.json());
app.use(logRequest);

app.listen(port, () => {
    console.log(`Connected at http://localhost:${port}`);
});

function logRequest(req, res, next) {
    logger.info(`${req.method} - ${req.url}`);
    next();
}

app.use('/bookings', bookingRouter); 
