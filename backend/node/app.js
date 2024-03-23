require("dotenv").config();
const express = require("express");
const userRouter = require("./routes/users");
const bookingRouter = require("./routes/bookings");
const teamsRouter = require("./routes/teams");
const { logRequest } = require("./middleware/logger");

const app = express();

app.use(express.json());
app.use(logRequest);

app.use("/users", userRouter);
app.use("/bookings", bookingRouter);
app.use("/teams", teamsRouter);

module.exports = app;
