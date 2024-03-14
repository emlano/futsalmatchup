const request = require("supertest");
const app = require("../app");
const db = require("../db");
const jwt = require("jsonwebtoken");
<<<<<<< HEAD
=======

<<<<<<< HEAD
const DuplicateTeamName = require("../errors/duplicateTeams");
>>>>>>> b24f2f4 (changes made in backend but not completed)

=======
>>>>>>> 8523146 (changes on node testing)
jest.mock("../db", () => ({
  getTeams: jest.fn(),
  getTeamFromId: jest.fn(),
  createNewTeam: jest.fn(),
  updateTeam: jest.fn(),
  deleteTeam: jest.fn(),
}));

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 8523146 (changes on node testing)
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
    const response = await request(app).get("/Teams/999");
    expect(response.status).toBe(404);
  });
});

describe("PUT /teams/:id", () => {
  // Test case for updating an existing teams
  test("should update a booking by id", async () => {
    const updatedTeams = { id: 1, name: "Updated Team 1" };
    db.updateTeam.mockResolvedValue(updatedTeams);

    const response = await request(app).put("/teams/1").send(updatedTeams);

    expect(response.status).toBe(200);
    expect(response.body).toEqual(updatedTeams);
  });

  // Test case for handling errors during update
  test("should handle errors when updating a team by id", async () => {
    const updatedTeamsData = {
      team_id: 2,
      start_date_time: "2024-03-11 16:00:00",
      end_date_time: "2024-03-11 17:00:00",
    };
    db.updateTeam.mockRejectedValue(new Error("Database error"));

    const response = await request(app)
      .put("/teams/1")
      .send({ id: 1, name: "Updated Team 1" });

    expect(response.status).toBe(500);
<<<<<<< HEAD
=======
describe("GET /teams", () => {
  // ... similar tests for fetching teams
});

describe("GET /teams/other", () => {
  // ... similar tests for fetching other teams
});

describe("POST /teams/", () => {
  test("Should return an error when arguments were not provided", async () => {
    const res = await request(app).post("/teams/create").send([]);

    expect(res.status).toBe(400);
    expect(res.body).toEqual({ error: "required arguments not given" });
  });

  test("should return an error if team name was not given", async () => {
    const res = await request(app).post("/teams/create").send([]);
    const res2 = await request(app)
      .post("/teams/create")
      .send([{ team_name: "name" }]);
    const res3 = await request(app).post("/teams/create");

    expect(res.status).toBe(400);
    expect(res.body).toEqual({ error: "team name not given" });

    expect(res2.status).toBe(400);
    expect(res2.body).toEqual({ error: "team name not given" });

    expect(res3.status).toBe(400);
    expect(res3.body).toEqual({ error: "team name not given" });
  });

  test("should return an error if team name is already used", async () => {
    const testData = [{ team_name: "teamname" }];

    db.createNewTeam.mockImplementation(async () => {
      throw new DuplicateTeamName();
    });

    const res = await request(app).post("/teams/create").send(testData);

    expect(res.status).toBe(409);
    expect(res.body).toEqual({ error: "team name already taken" });
  });

  test("should return a token when inputs are valid", async () => {
    const testData = [{ team_id: 1, team_name: "team" }];
    const token = jwt.sign(testData[0], process.env.ACCESS_TOKEN_SECRET, {
      expiresIn: 60 * 60,
    });

    db.createNewTeam.mockResolvedValue(testData);

    const res = await request(app).post("/teams/create").send(testData);

    expect(res.status).toBe(200);
    expect(res.body.accessToken).toBeDefined();
>>>>>>> b24f2f4 (changes made in backend but not completed)
=======
>>>>>>> 8523146 (changes on node testing)
  });
});
