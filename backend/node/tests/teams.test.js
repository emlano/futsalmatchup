const request = require("supertest");
const app = require("../app");
const db = require("../db");
const jwt = require("jsonwebtoken");

jest.mock("../db", () => ({
  getTeams: jest.fn(),
  getTeamFromId: jest.fn(),
  createNewTeam: jest.fn(),
  updateTeam: jest.fn(),
  deleteTeam: jest.fn(),
}));

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
  });
});
