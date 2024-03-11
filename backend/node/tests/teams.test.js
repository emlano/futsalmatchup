const request = require("supertest");
const app = require("../app");
const db = require("../db");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");

const DuplicateTeamName = require("../errors/duplicateTeam");

jest.mock("../db", () => ({
  getTeams: jest.fn(),
  getTeamFromId: jest.fn(),
  getTeamFromName: jest.fn(),
  createNewTeam: jest.fn(),
  updateTeam: jest.fn(),
  deleteTeam: jest.fn(),
}));

describe("GET /teams", () => {
  // ... similar tests for fetching teams
});

describe("GET /teams/other", () => {
  // ... similar tests for fetching other teams
});

describe("POST /teams/create", () => {
  test("Should return an error when arguments were not provided", async () => {
    const testData = [{ team_id: 1, team_name: "team", password: "password" }];
    const token = await jwt.sign(testData[0], process.env.ACCESS_TOKEN_SECRET);

    const res = await request(app)
      .post("/teams/create")
      .set("Authorization", `Bearer ${token}`)
      .send([]);

    expect(res.status).toBe(400);
    expect(res.body).toEqual({ error: "required arguments not given" });
  });

  test("should return an error if team name or password was not given", async () => {
    const res = await request(app).post("/teams/create").send([{}]);
    const res2 = await request(app)
      .post("/teams/create")
      .send([{ team_name: "name" }]);
    const res3 = await request(app)
      .post("/teams/create")
      .send([{ password: "pass" }]);

    expect(res.status).toBe(400);
    expect(res.body).toEqual({ error: "team name or password not given" });

    expect(res2.status).toBe(400);
    expect(res2.body).toEqual({ error: "team name or password not given" });

    expect(res3.status).toBe(400);
    expect(res3.body).toEqual({ error: "team name or password not given" });
  });

  test("should return an error if team name is already used", async () => {
    const testData = [{ team_name: "teamname", password: "password" }];

    db.createNewTeam.mockImplementation(async () => {
      throw new DuplicateTeamName();
    });

    const res = await request(app).post("/teams/create").send(testData);

    expect(res.status).toBe(409);
    expect(res.body).toEqual({ error: "team name already taken" });
  });

  test("should return a token when inputs are valid", async () => {
    const testData = [{ team_id: 1, team_name: "team", password: "password" }];
    const token = jwt.sign(testData[0], process.env.ACCESS_TOKEN_SECRET, {
      expiresIn: 60 * 60,
    });

    db.createNewTeam.mockResolvedValue(testData);

    const res = await request(app).post("/teams/create").send(testData);

    expect(res.status).toBe(200);
    expect(res.body.accessToken).toBeDefined();
  });
});