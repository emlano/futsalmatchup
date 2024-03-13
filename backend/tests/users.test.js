const request = require("supertest");
const app = require("../app");
const db = require("../db");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");

const DuplicateUsername = require("../errors/duplicateUser");

jest.mock("../db", () => ({
  getUsers: jest.fn(),
  getUserFromId: jest.fn(),
  getUserFromName: jest.fn(),
  getUserFromNameWithPassword: jest.fn(),
  createNewUser: jest.fn(),
  updateUser: jest.fn(),
  deleteUser: jest.fn(),
}));

describe("GET /users", () => {
  test("should disallow when token wasn't given", async () => {
    const res = await request(app).get("/users/");

    expect(res.status).toBe(401);
    expect(res.body).toEqual({ error: "no authorization token given" });
  });

  test("should disallow when token was wrong", async () => {
    const token = "NotAValidToken";
    const res = await request(app)
      .get("/users/")
      .set("Authorization", `Bearer ${token}`);

    expect(res.status).toBe(403);
    expect(res.body).toEqual({ error: "malformed or expired token" });
  });

  test("should disallow when token is expired", async () => {
    const testdata = { user_id: 1, username: "user", password: "password" };
    const token = jwt.sign(testdata, process.env.ACCESS_TOKEN_SECRET, {
      expiresIn: -1,
    });

    const res = await request(app)
      .get("/users/")
      .set("Authorization", `Bearer ${token}`);

    expect(res.status).toBe(403);
    expect(res.body).toEqual({ error: "malformed or expired token" });
  });

  test("should fetch data when token was provided", async () => {
    const testdata = { user_id: 1, username: "user", password: "password" };
    const token = jwt.sign(testdata, process.env.ACCESS_TOKEN_SECRET);
    db.getUserFromId.mockResolvedValue(testdata);

    const res = await request(app)
      .get("/users/")
      .set("Authorization", `Bearer ${token}`);

    expect(res.status).toBe(200);
    expect(res.body).toEqual(testdata);
  });

  test("should send an error when user was not found", async () => {
    const testdata = { user_id: 1, username: "user", password: "password" };
    const token = jwt.sign(testdata, process.env.ACCESS_TOKEN_SECRET);
    db.getUserFromId.mockResolvedValue([]);

    const res = await request(app)
      .get("/users/")
      .set("Authorization", `Bearer ${token}`);

    expect(res.status).toBe(404);
    expect(res.body).toEqual({ error: "user not found" });
  });
});

describe("GET /users/other", () => {
  test("Should return an error when arguments were not provided", async () => {
    const testdata = [{ user_id: 1, username: "user", password: "password" }];
    const token = await jwt.sign(testdata[0], process.env.ACCESS_TOKEN_SECRET);

    const res = await request(app)
      .get("/users/other")
      .set("Authorization", `Bearer ${token}`)
      .send([]);

    expect(res.status).toBe(400);
    expect(res.body).toEqual({
      error: "missing arguments or malformed request",
    });
  });

  test("should return an error when user was not found", async () => {
    const testdata = { user_id: 1, username: "user", password: "password" };
    const token = jwt.sign(testdata, process.env.ACCESS_TOKEN_SECRET);

    db.getUserFromId.mockResolvedValue([]);
    db.getUserFromName.mockResolvedValue([]);

    const res = await request(app)
      .get("/users/other")
      .set("Authorization", `Bearer ${token}`)
      .send([{ id: 2 }]);

    const res2 = await request(app)
      .get("/users/other")
      .set("Authorization", `Bearer ${token}`)
      .send([{ username: "name" }]);

    expect(res.status).toBe(404);
    expect(res.body).toEqual({ error: "user not found" });

    expect(res2.status).toBe(404);
    expect(res2.body).toEqual({ error: "user not found" });
  });

  test("should return an error when username or id is missing", async () => {
    const testdata = { user_id: 1, username: "user", password: "password" };
    const other = [{ user: "user" }];
    const token = jwt.sign(testdata, process.env.ACCESS_TOKEN_SECRET);

    const res = await request(app)
      .get("/users/other")
      .set("Authorization", `Bearer ${token}`)
      .send(other);

    expect(res.status).toBe(400);
    expect(res.body).toEqual({
      error: "requested users id or username not given",
    });
  });

  test("should return other users when either id or username was given", async () => {
    const testdata = { user_id: 1, username: "user", password: "password" };
    const token = jwt.sign(testdata, process.env.ACCESS_TOKEN_SECRET);

    const user1 = [{ user_id: 2, username: "name", password: "password" }];
    const user2 = [{ user_id: 3, username: "user", password: "password" }];

    db.getUserFromId.mockResolvedValue(user1);
    db.getUserFromName.mockResolvedValue(user2);

    const res = await request(app)
      .get("/users/other")
      .set("Authorization", `Bearer ${token}`)
      .send([{ id: 2 }]);

    const res2 = await request(app)
      .get("/users/other")
      .set("Authorization", `Bearer ${token}`)
      .send([{ username: "user" }]);

    expect(res.status).toBe(200);
    expect(res.body).toEqual(user1);

    expect(res2.status).toBe(200);
    expect(res2.body).toEqual(user2);
  });
});

describe("POST /users/signup", () => {
  test("Should return an error when arguments were not provided", async () => {
    const testdata = [{ user_id: 1, username: "user", password: "password" }];
    const token = await jwt.sign(testdata[0], process.env.ACCESS_TOKEN_SECRET);

    const res = await request(app)
      .post("/users/signup")
      .set("Authorization", `Bearer ${token}`)
      .send([]);

    expect(res.status).toBe(400);
    expect(res.body).toEqual({
      error: "missing arguments or malformed request",
    });
  });

  test("should return an error if username or password was not given", async () => {
    const res = await request(app).post("/users/signup").send([{}]);
    const res2 = await request(app)
      .post("/users/signup")
      .send([{ username: "name" }]);
    const res3 = await request(app)
      .post("/users/signup")
      .send([{ password: "pass" }]);

    expect(res.status).toBe(400);
    expect(res.body).toEqual({ error: "username or password not given" });

    expect(res2.status).toBe(400);
    expect(res2.body).toEqual({ error: "username or password not given" });

    expect(res3.status).toBe(400);
    expect(res3.body).toEqual({ error: "username or password not given" });
  });

  test("should return an error if username is already used", async () => {
    const testdate = [{ username: "username", password: "password" }];

    db.createNewUser.mockImplementation(async () => {
      throw new DuplicateUsername();
    });

    const res = await request(app).post("/users/signup").send(testdate);

    expect(res.status).toBe(409);
    expect(res.body).toEqual({ error: "username already taken" });
  });

  test("should return a token when inputs are valid", async () => {
    const testdata = [{ user_id: 1, username: "user", password: "password" }];
    const token = jwt.sign(testdata[0], process.env.ACCESS_TOKEN_SECRET, {
      expiresIn: 60 * 60,
    });

    db.createNewUser.mockResolvedValue(testdata);

    const res = await request(app).post("/users/signup").send(testdata);

    expect(res.status).toBe(200);
    expect(res.body.accessToken).toBeDefined();
  });
});

describe("POST /users/login", () => {
  test("Should return an error when arguments were not provided", async () => {
    const testdata = [{ user_id: 1, username: "user", password: "password" }];
    const token = await jwt.sign(testdata[0], process.env.ACCESS_TOKEN_SECRET);

    const res = await request(app)
      .post("/users/login")
      .set("Authorization", `Bearer ${token}`)
      .send([]);

    expect(res.status).toBe(400);
    expect(res.body).toEqual({
      error: "missing arguments or malformed request",
    });
  });

  test("should return error if the user isn't in database", async () => {
    const testdata = [{ username: "user", password: "pass" }];

    db.getUserFromNameWithPassword.mockResolvedValue([]);

    const res = await request(app).post("/users/login").send(testdata);

    expect(res.status).toBe(404);
    expect(res.body).toEqual({ error: "no such user found" });
  });

  test("should return error if the username or password is wrong", async () => {
    const testdata = [{ username: "user", password: "notpass" }];
    const testdata2 = [{ username: "username", password: "password" }];

    const hashedPass = await bcrypt.hash("password", 10);
    const resultdata = [{ username: "user", password: hashedPass }];

    db.getUserFromNameWithPassword.mockResolvedValue(resultdata);

    const res = await request(app).post("/users/login").send(testdata);
    const res2 = await request(app).post("/users/login").send(testdata2);

    expect(res.status).toBe(401);
    expect(res.body).toEqual({ error: "username or password is incorrect" });

    expect(res2.status).toBe(401);
    expect(res2.body).toEqual({ error: "username or password is incorrect" });
  });

  test("should return token when provided info is correct", async () => {
    const testdata = [{ username: "user", password: "password" }];

    const hashedPass = await bcrypt.hash("password", 10);
    const resultdata = [{ username: "user", password: hashedPass }];

    const token = jwt.sign(resultdata[0], process.env.ACCESS_TOKEN_SECRET, {
      expiresIn: 60 * 60,
    });

    db.getUserFromNameWithPassword.mockResolvedValue(resultdata);

    const res = await request(app).post("/users/login").send(testdata);

    expect(res.status).toBe(200);
    expect(res.body.accessToken).toBeDefined();
  });
});

describe("PUT /users/", () => {
  test("Should return an error when arguments were not provided", async () => {
    const testdata = [{ user_id: 1, username: "user", password: "password" }];
    const token = await jwt.sign(testdata[0], process.env.ACCESS_TOKEN_SECRET);

    const res = await request(app)
      .put("/users/")
      .set("Authorization", `Bearer ${token}`)
      .send([]);

    expect(res.status).toBe(400);
    expect(res.body).toEqual({
      error: "missing arguments or malformed request",
    });
  });

  test("Should modify data when info was provided", async () => {
    const testdata = [{ user_id: 1, username: "user", password: "password" }];
    const token = await jwt.sign(testdata[0], process.env.ACCESS_TOKEN_SECRET);

    const res = await request(app)
      .put("/users/")
      .set("Authorization", `Bearer ${token}`)
      .send([{ player_city: "New York" }]);

    expect(res.status).toBe(200);
    expect(res.body).toEqual({ status: "success" });
  });
});

describe("DELETE /users/", () => {
  test("Should delete user when token is provided", async () => {
    const testdata = [{ user_id: 1, username: "user", password: "password" }];
    const token = await jwt.sign(testdata[0], process.env.ACCESS_TOKEN_SECRET);

    const res = await request(app)
      .delete("/users/")
      .set("Authorization", `Bearer ${token}`);

    expect(res.status).toBe(200);
    expect(res.body).toEqual({ status: "success" });
  });
});
