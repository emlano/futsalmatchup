const request = require("supertest");
const app = require("../app");
const db = require("../db");
const jwt = require("jsonwebtoken");
const DuplicateTeamName = require("../errors/duplicateTeams");

jest.mock("../db", () => ({
  getTeams: jest.fn(),
  getTeamFromId: jest.fn(),
  createNewTeam: jest.fn(),
  updateTeam: jest.fn(),
  deleteTeam: jest.fn(),
}));

//test case to get teams
describe("GET /teams/", () => {
  test("should return all teams", async () => {
    const mockTeams = [
      { id: 1, name: "teams 1" },
      { id: 2, name: "teams 2" },
    ];
    db.getTeams.mockResolvedValue(mockTeams);
    const response = await request(app).get("/teams");
    expect(response.status).toBe(200);
    expect(response.body).toEqual(mockTeams);
  });
});

//test case to get teams by id
describe("GET /teams/:id", () => {
  test("should return teams with given id", async () => {
    const mockTeams = { id: 1, name: "team 1" };
    db.getTeamFromId.mockResolvedValue(mockTeams);
    const response = await request(app).get("/teams/1");
    expect(response.status).toBe(200);
    expect(response.body).toEqual(mockTeams);
  });

  test("should return 404 if team with given id is not found", async () => {
    db.getTeamFromId.mockResolvedValue(null);
    const response = await request(app).get("/teams/999");
    expect(response.status).toBe(404);
  });
});

// Test case for updating an existing teams
describe("PUT /teams/:id", () => {
  test("should update a booking by id", async () => {
    const updatedTeams = { id: 1, name: "Updated Team 1" };
    const user = { user_id: 0, name: "user" };
    const token = jwt.sign(user, process.env.ACCESS_TOKEN_SECRET);
    db.updateTeam.mockResolvedValue(updatedTeams);

    const response = await request(app)
      .put("/teams/1")
      .send(updatedTeams)
      .set("Authorization", `Bearer ${token}`);

    expect(response.status).toBe(200);
    expect(response.body).toEqual(updatedTeams);
  });
});

//test case to add teams
describe("POST /teams/", () => {
  test("Should return an error when arguments were not provided", async () => {
    const user = { user_id: 0, name: "user" };
    const token = jwt.sign(user, process.env.ACCESS_TOKEN_SECRET);

    const res = await request(app)
      .post("/teams/")
      .send([])
      .set("Authorization", `Bearer ${token}`);

    expect(res.status).toBe(400);
    expect(res.body).toEqual({
      error: "missing arguments or malformed request",
    });
  });

  test("should return an error if team name was not given", async () => {
    const user = { user_id: 0, name: "user" };
    const token = jwt.sign(user, process.env.ACCESS_TOKEN_SECRET);
    db.createNewTeam.mockResolvedValue([]);

    const res = await request(app)
      .post("/teams/")
      .send([])
      .set("Authorization", `Bearer ${token}`);

    expect(res.status).toBe(400);
    expect(res.body).toEqual({
      error: "missing arguments or malformed request",
    });
  });
});
