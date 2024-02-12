CREATE DATABASE futsalMatchUp;
USE futsalMatchUp;

CREATE TABLE players (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100),
    password VARCHAR(100),
    phone_no VARCHAR(100),
    player_skill_rating DOUBLE,
    player_sportsmanship_rating DOUBLE,
    player_overall_rating DOUBLE,
    player_city VARCHAR(100),
    player_availability BOOLEAN,
    player_position VARCHAR(50),
    team_id INT,
    -- player_profile_pic BLOB
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

CREATE TABLE managers (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100),
    password VARCHAR(100),
    phone_no VARCHAR(100),
    manager_position VARCHAR(100),
    stadium_id INT, 
    FOREIGN KEY (stadium_id) REFERENCES stadiums(stadium_id) 
);

CREATE TABLE teams (
    team_id INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(100)
    -- team_profile_pic BLOB
    -- team_members
);

CREATE TABLE stadiums (
    stadium_id INT AUTO_INCREMENT PRIMARY KEY,
    stadium_name VARCHAR(100),
    stadium_location VARCHAR(100)
    -- stadium_schedule 
);

CREATE TABLE team_members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    player_id INT,
    FOREIGN KEY (team_id) REFERENCES teams(team_id),
    FOREIGN KEY (player_id) REFERENCES players(user_id)
);

CREATE TABLE stadium_schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    stadium_id INT,
    start_date_time DATETIME,
    end_date_time DATETIME,
    FOREIGN KEY (stadium_id) REFERENCES stadiums(stadium_id)
);

CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    stadium_id INT,
    team_id INT,
    user_id INT,
    start_date_time DATETIME,
    end_date_time DATETIME,
    FOREIGN KEY (stadium_id) REFERENCES stadiums(stadium_id),
    FOREIGN KEY (team_id) REFERENCES teams(team_id),
    FOREIGN KEY (user_id) REFERENCES players(user_id)
);
