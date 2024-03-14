const mysql = require("mysql2");
const { exceptions } = require("winston");
const DuplicateUsername = require("./errors/duplicateUser");
<<<<<<< HEAD
<<<<<<< HEAD
const DuplicateTeamName = require("./errors/duplicateTeams");
=======
const DuplicateTeamName = require("../errors/duplicateTeams");
>>>>>>> b24f2f4 (changes made in backend but not completed)
=======
const DuplicateTeamName = require("./errors/duplicateTeams");
>>>>>>> 8523146 (changes on node testing)

const pool = mysql
  .createPool({
    host: process.env.HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE,
  })
  .promise();

async function getAllUsersExcept(user_id) {
  try {
    const [rows] = await pool.query(
      `
      SELECT 
        user_id,
        username,
        player_skill_rating,
        player_sportsmanship_rating,
        player_overall_rating,
        player_rated_times,
        player_city,
        player_availability,
        player_position,
        team_id
      FROM players
      WHERE user_id != ?;
    `,
      [user_id]
    );
    return rows;
  } catch (err) {
    console.error(err);
  }
}

async function getUserFromId(id) {
  const [rows] = await pool.query(
    `
      SELECT
          user_id,
          username,
          player_skill_rating,
          player_sportsmanship_rating,
          player_overall_rating,
          player_rated_times,
          player_city,
          player_availability,
          player_position,
          team_id
      FROM players 
      WHERE user_id = ?;`,
    [id]
  );

  return rows;
}

async function getUserFromName(name) {
  const [rows] = await pool.query(
    `
        SELECT
            user_id,
            username,
            player_skill_rating,
            player_sportsmanship_rating,
            player_overall_rating,
            player_rated_times,
            player_city,
            player_availability,
            player_position,
            team_id
        FROM players
        WHERE username 
        LIKE ?;`,
    [name]
  );

  return rows;
}

async function getUserFromNameWithPassword(name) {
  const [rows] = await pool.query(
    `
        SELECT *
        FROM players
        WHERE username 
        LIKE ?;`,
    [name]
  );

  return rows;
}

async function createNewUser(user) {
  const username = user.username;
  const password = user.password;
  const phoneNo = user.phone_no;

  const [duplicates] = await pool.query(
    `
    SELECT * FROM players WHERE username LIKE ?;
    `,
    [username]
  );

  if (duplicates.length != 0) {
    throw new DuplicateUsername();
  }

  const [result] = await pool.query(
    `
        INSERT INTO players (
            username, 
            password, 
            phone_no, 
            player_skill_rating, 
            player_sportsmanship_rating, 
            player_overall_rating,
            player_rated_times,
            player_availability
        )
        VALUES
        (?, ?, ?, ?, ?, ?, ?, ?);`,
    [username, password, phoneNo, 3.5, 3.5, 3.5, 1, true]
  );

  return getUserFromNameWithPassword(username);
}

async function updateUser(user, id) {
  const skillRating = user.player_skill_rating;
  const sportsmanship = user.player_sportsmanship_rating;
  const overallRating = user.player_overall_rating;
  const ratedTimes = user.player_rated_times;
  const city = user.player_city;
  const availability = user.player_availability;
  const position = user.player_position;
  const teamId = user.team_id;

  if (skillRating != null) {
    result = await pool.query(
      `
            UPDATE players
            SET player_skill_rating = ?
            WHERE user_id = ? ;`,
      [skillRating, id]
    );
  }

  if (sportsmanship != null) {
    result = await pool.query(
      `
            UPDATE players
            SET player_sportsmanship_rating = ?
            WHERE user_id = ? ;`,
      [sportsmanship, id]
    );
  }

  if (overallRating != null) {
    result = await pool.query(
      `
            UPDATE players
            SET player_overall_rating = ?
            WHERE user_id = ? ;`,
      [overallRating, id]
    );
  }

  if (ratedTimes != null) {
    result = await pool.query(
      `
            UPDATE players
            SET player_rated_times = ?
            WHERE user_id = ? ;`,
      [ratedTimes, id]
    );
  }

  if (city != null) {
    result = await pool.query(
      `
            UPDATE players
            SET player_city = ?
            WHERE user_id = ? ;`,
      [city, id]
    );
  }

  if (availability != null) {
    result = await pool.query(
      `
            UPDATE players
            SET player_availability = ?
            WHERE user_id = ? ;`,
      [availability, id]
    );
  }

  if (position != null) {
    result = await pool.query(
      `
            UPDATE players
            SET player_position = ?
            WHERE user_id = ? ;`,
      [position, id]
    );
  }

  if (teamId != null) {
    result = await pool.query(
      `
            UPDATE players
            SET team_id = ?
            WHERE user_id = ? ;`,
      [teamId, id]
    );
  }

  return result;
}

async function deleteUser(id) {
  const [result] = await pool.query(
    `
        DELETE FROM players
        WHERE user_id = ?`,
    [id]
  );

  return result;
}

async function getBookings() {
  const [rows] = await pool.query("SELECT * FROM `bookings`;");
  return rows;
}

async function getBookingFromId(id) {
  const [rows] = await pool.query(
    `
    SELECT * 
    FROM bookings 
    WHERE booking_id = ?;`,
    [id]
  );

  return rows;
}

async function createNewBooking(booking) {
  const { stadium_id, team_id, user_id, start_date_time, end_date_time } =
    booking;
  const [result] = await pool.query(
    `
        INSERT INTO bookings (stadium_id, team_id, user_id, start_date_time, end_date_time) 
        VALUES (?, ?, ?, ?, ?);`,
    [stadium_id, team_id, user_id, start_date_time, end_date_time]
  );
  return result;
}
async function updateBooking(bookingId, updatedBooking) {
  const { stadium_id, team_id, user_id, start_date_time, end_date_time } =
    updatedBooking;

  const [result] = await pool.query(
    `
        UPDATE bookings
        SET
            stadium_id = ?,
            team_id = ?,
            user_id = ?,
            start_date_time = ?,
            end_date_time = ?
        WHERE booking_id = ?;`,
    [stadium_id, team_id, user_id, start_date_time, end_date_time, bookingId]
  );

  return result;
}
async function deleteBooking(bookingId) {
  const [result] = await pool.query(
    `
        DELETE FROM bookings
        WHERE booking_id = ?`,
    [bookingId]
  );

  return result;
}

async function getTeams() {
  const [rows] = await pool.query("SELECT * FROM `teams`;");
  return rows;
}

async function getTeamFromId(id) {
  const [rows] = await pool.query(
    `
        SELECT
            team_id,
            team_name,
        FROM teams 
        WHERE team_id = ?;`,
    [id]
  );

  return rows;
}

async function createNewTeam(team) {
  const { team_id, team_name } = team;
  const [result] = await pool.query(
    `
        INSERT INTO teams (team_id,team_name) 
        VALUES (?, ?);`,
    [team_id, team_name]
  );

  return result;
}

<<<<<<< HEAD
<<<<<<< HEAD
async function updateTeam(team_id, updatedTeam) {
  const { teamId, team_name } = updatedTeam;
=======
async function updateTeam(ID, updatedTeam) {
  const { team_name } = updatedTeam;
>>>>>>> b24f2f4 (changes made in backend but not completed)
=======
async function updateTeam(team_id, updatedTeam) {
  const { teamId, team_name } = updatedTeam;
>>>>>>> 8523146 (changes on node testing)

  const [result] = await pool.query(
    `
        UPDATE teams
        SET
            teamID=?,
            team_name = ?,
            
        WHERE team_id = ?;`,
<<<<<<< HEAD
<<<<<<< HEAD
    [teamId, team_name]
=======
    [team_name, ID]
>>>>>>> b24f2f4 (changes made in backend but not completed)
=======
    [teamId, team_name]
>>>>>>> 8523146 (changes on node testing)
  );

  return result;
}

async function deleteTeam(teamId) {
  const [result] = await pool.query(
    `
        DELETE FROM teams
        WHERE team_id = ?;`,
    [teamId]
  );

  return result;
}

async function getStadiums() {
  const [rows] = await pool.query("SELECT * FROM `stadiums`;");
  return rows;
}

async function getStadiumFromId(id) {
  const [rows] = await pool.query(
    `
    SELECT * 
    FROM stadiums 
    WHERE stadium_id = ?;`,
    [id]
  );

  return rows;
}

async function createNewStadium(stadium) {
  const { stadium_name, capacity, location } = stadium;
  const [result] = await pool.query(
    `
        INSERT INTO stadiums (stadium_name, capacity, location) 
        VALUES (?, ?, ?);`,
    [stadium_name, capacity, location]
  );

  return result;
}

async function updateStadium(stadiumId, updatedStadium) {
  const { stadium_name, capacity, location } = updatedStadium;

  const [result] = await pool.query(
    `
        UPDATE stadiums
        SET
            stadium_name = ?,
            capacity = ?,
            location = ?
        WHERE stadium_id = ?;`,
    [stadium_name, capacity, location, stadiumId]
  );

  return result;
}

async function deleteStadium(stadiumId) {
  const [result] = await pool.query(
    `
        DELETE FROM stadiums
        WHERE stadium_id = ?;`,
    [stadiumId]
  );

  return result;
}

module.exports = {
  getAllUsersExcept,
  getUserFromId,
  getUserFromName,
  getUserFromNameWithPassword,
  createNewUser,
  updateUser,
  deleteUser,
  getBookings,
  getBookingFromId,
  createNewBooking,
  updateBooking,
  deleteBooking,
  getTeams,
  getTeamFromId,
  createNewTeam,
  updateTeam,
  deleteTeam,
  getStadiums,
  getStadiumFromId,
  createNewStadium,
  updateStadium,
  deleteStadium,
};