const express = require("express");
const app = express();
const port = 3000;

app.use(express.json());

app.listen(port, () => {
    console.log(`Connected at http://localhost:${port}`);
})

const userRouter = require('./routes/users')

app.use('/users', userRouter)