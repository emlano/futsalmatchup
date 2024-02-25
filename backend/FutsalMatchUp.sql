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
);

CREATE TABLE stadiums (
    stadium_id INT AUTO_INCREMENT PRIMARY KEY,
    stadium_name VARCHAR(100),
    stadium_location VARCHAR(100)
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

INSERT INTO bookings (stadium_id, team_id, user_id, start_date_time, end_date_time) VALUES
(1, 1, 1, '2024-03-01 10:00:00', '2024-03-01 11:00:00'),
(2, 3, 4, '2024-03-02 15:00:00', '2024-03-02 17:00:00'),
(3, 5, 8, '2024-03-03 09:00:00', '2024-03-03 10:30:00'),
(4, 7, 10, '2024-03-04 14:00:00', '2024-03-04 15:30:00'),
(5, 9, 12, '2024-03-05 18:00:00', '2024-03-05 19:30:00'),
(6, 11, 14, '2024-03-06 12:00:00', '2024-03-06 13:30:00'),
(7, 13, 16, '2024-03-07 16:00:00', '2024-03-07 17:30:00'),
(8, 15, 18, '2024-03-08 11:00:00', '2024-03-08 12:30:00'),
(9, 17, 20, '2024-03-09 13:00:00', '2024-03-09 14:30:00'),
(10, 19, 2, '2024-03-10 19:00:00', '2024-03-10 20:30:00');
