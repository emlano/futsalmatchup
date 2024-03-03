const request = require("supertest")
const app = require("../app")
const db = require("../db")
const jwt  = require("jsonwebtoken")

jest.mock("../db", () => ({
    getUsers: jest.fn(),
    getUserFromId: jest.fn()
}))


describe("GET /users", () => {
    test("should disallow when token wasn't given", async () => {
        const testdata = { "error": "No authetication token given" }
        db.getUsers.mockResolvedValue(testdata)

        const res = await request(app).get("/users")

        expect(res.status).toBe(401)
        expect(res.body).toEqual(testdata)
    })

    test("should fetch data when token was provided", async () => {
        const testdata = { user_id: 1, username: "user", password: "password" }
        const token = jwt.sign(testdata, process.env.ACCESS_TOKEN_SECRET)
        db.getUserFromId.mockResolvedValue(testdata)

        const res = await request(app).get("/users").set("Authorization", `Bearer ${token}`)

        expect(res.status).toBe(200)
        expect(res.body).toEqual(testdata)
    })
})