CREATE DATABASE futsalMatchUp;
USE futsalMatchUp;

CREATE TABLE teams (
    team_id INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(100)
);

CREATE TABLE stadiums (
    stadium_id INT AUTO_INCREMENT PRIMARY KEY,
    stadium_name VARCHAR(100),
    stadium_location VARCHAR(100)
);

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

-- Populate Tables
-- Insert 20 values into the 'teams' table
INSERT INTO teams (team_name) VALUES
('Barcelona FC'),
('Real Madrid CF'),
('Manchester United'),
('Liverpool FC'),
('Juventus FC'),
('Paris Saint-Germain'),
('Bayern Munich'),
('Manchester City'),
('Chelsea FC'),
('AC Milan'),
('Arsenal FC'),
('Tottenham Hotspur'),
('Borussia Dortmund'),
('Inter Milan'),
('Atletico Madrid'),
('AS Roma'),
('Ajax Amsterdam'),
('FC Porto'),
('Olympique Lyonnais'),
('Napoli');

-- Insert 20 values into the 'stadiums' table
INSERT INTO stadiums (stadium_name, stadium_location) VALUES
('Camp Nou', 'Barcelona, Spain'),
('Santiago Bernabeu', 'Madrid, Spain'),
('Old Trafford', 'Manchester, England'),
('Anfield', 'Liverpool, England'),
('Allianz Stadium', 'Turin, Italy'),
('Parc des Princes', 'Paris, France'),
('Allianz Arena', 'Munich, Germany'),
('Etihad Stadium', 'Manchester, England'),
('Stamford Bridge', 'London, England'),
('San Siro', 'Milan, Italy'),
('Emirates Stadium', 'London, England'),
('Tottenham Hotspur Stadium', 'London, England'),
('Signal Iduna Park', 'Dortmund, Germany'),
('San Siro', 'Milan, Italy'),
('Wanda Metropolitano', 'Madrid, Spain'),
('Stadio Olimpico', 'Rome, Italy'),
('Johan Cruyff Arena', 'Amsterdam, Netherlands'),
('Estadio do Dragao', 'Porto, Portugal'),
('Groupama Stadium', 'Lyon, France'),
('Stadio San Paolo', 'Naples, Italy');

-- Insert 20 values into the 'players' table
INSERT INTO players (username, password, phone_no, player_skill_rating, player_sportsmanship_rating, player_overall_rating, player_city, player_availability, player_position, team_id) VALUES
('LeoMessi', 'JGo6kR3Pn4', '1234567890', 9.5, 9.0, 9.25, 'Barcelona', TRUE, 'Forward', 1),
('CristianoRonaldo', 'Bz7mYq0Kv9', '1234567891', 9.4, 9.5, 9.45, 'Turin', TRUE, 'Forward', 5),
('Neymar Jr', 'Yp5dRv1Nj3', '1234567892', 9.3, 8.5, 8.9, 'Paris', TRUE, 'Forward', 6),
('LionelMessi', 'Xz4lPo2Mh7', '1234567893', 9.5, 9.0, 9.25, 'Barcelona', TRUE, 'Forward', 1),
('Kevin De Bruyne', 'Nw9sPt0Lg2', '1234567894', 9.2, 9.5, 9.35, 'Manchester', TRUE, 'Midfielder', 8),
('Sergio Ramos', 'Kt6pGw5Jf2', '1234567895', 9.0, 9.8, 9.4, 'Madrid', TRUE, 'Defender', 2),
('Robert Lewandowski', 'Qj3oRh8Ws5', '1234567896', 9.3, 9.0, 9.15, 'Munich', TRUE, 'Forward', 7),
('Mohamed Salah', 'Ri1qHu4Xp8', '1234567897', 9.2, 9.3, 9.25, 'Liverpool', TRUE, 'Forward', 4),
('Harry Kane', 'Ue5dTw3Ky1', '1234567898', 9.1, 9.2, 9.15, 'London', TRUE, 'Forward', 12),
('Virgil van Dijk', 'Zy6gIv7Re0', '1234567899', 9.4, 9.6, 9.5, 'Liverpool', TRUE, 'Defender', 4),
('Alisson Becker', 'Vx2fLw9Yp5', '1234567800', 9.5, 9.2, 9.35, 'Liverpool', TRUE, 'Goalkeeper', 4),
('Kylian Mbappe', 'Fd3tNu0Jy6', '1234567801', 9.6, 8.8, 9.2, 'Paris', TRUE, 'Forward', 6),
('Jan Oblak', 'So4eFj7Yq9', '1234567802', 9.3, 9.5, 9.4, 'Madrid', TRUE, 'Goalkeeper', 2),
('Bruno Fernandes', 'Mw1nHk4Ut7', '1234567803', 9.2, 9.4, 9.3, 'Manchester', TRUE, 'Midfielder', 8),
('Joshua Kimmich', 'Dr9oPj2Qw5', '1234567804', 9.1, 9.6, 9.35, 'Munich', TRUE, 'Midfielder', 7),
('Romelu Lukaku', 'Lq0rYi9Ju3', '1234567805', 9.2, 9.0, 9.1, 'Milan', TRUE, 'Forward', 10),
('Trent Alexander-Arnold', 'Xe7mOp3Rt2', '1234567806', 9.0, 9.3, 9.15, 'Liverpool', TRUE, 'Defender', 4),
('Jadon Sancho', 'Bt6lSp9Mw0', '1234567807', 9.2, 9.0, 9.1, 'Dortmund', TRUE, 'Forward', 13),
('Ederson', 'Qw5sJy9Gz3', '1234567808', 9.4, 9.2, 9.3, 'Manchester', TRUE, 'Goalkeeper', 8),
('Luis Suarez', 'Hn3vTl6Mi9', '1234567809', 9.3, 9.1, 9.2, 'Madrid', TRUE, 'Forward', 2);

-- Insert 20 values into the 'managers' table
INSERT INTO managers (username, password, phone_no, manager_position, stadium_id) VALUES
('Pep Guardiola', 'Fh9zSn5Mw1', '1234567890', 'Head Coach', 8),
('Jurgen Klopp', 'Ja7hDp3Kt9', '1234567891', 'Head Coach', 4),
('Zinedine Zidane', 'Lp8jGt2Xz3', '1234567892', 'Head Coach', 2),
('Diego Simeone', 'We5sJu0Gx8', '1234567893', 'Head Coach', 15),
('Thomas Tuchel', 'Yq6wSt3Rv9', '1234567894', 'Head Coach', 9),
('Antonio Conte', 'Tk4iVg7Rs2', '1234567895', 'Head Coach', 10),
('Mauricio Pochettino', 'Jy3tFh8Ln4', '1234567896', 'Head Coach', 6),
('Carlo Ancelotti', 'Mo9uVr6Qp3', '1234567897', 'Head Coach', 1),
('Julian Nagelsmann', 'Rw5zHp2Xq7', '1234567898', 'Head Coach', 13),
('Ole Gunnar Solskjaer', 'Dp1fSn8Mz4', '1234567899', 'Head Coach', 3),
('Roberto Mancini', 'Zx2wGj6Rv1', '1234567800', 'Head Coach', 12),
('Marcelo Bielsa', 'Nu7hTk4Zm3', '1234567801', 'Head Coach', 20),
('Erik ten Hag', 'Mz4wLu7Pq0', '1234567802', 'Head Coach', 17),
('Rudi Garcia', 'Bv9iOp6Tw2', '1234567803', 'Head Coach', 19),
('Jose Mourinho', 'Hj6fBg3Vr1', '1234567804', 'Head Coach', 11),
('Gian Piero Gasperini', 'Vx1gFr9Tk4', '1234567805', 'Head Coach', 16),
('Ralf Rangnick', 'En8lSb5Td2', '1234567806', 'Head Coach', 5),
('Maurizio Sarri', 'Lm0uGn4Xp9', '1234567807', 'Head Coach', 14),
('Lucien Favre', 'Fa8kDp2Yr3', '1234567808', 'Head Coach', 18),
('Jesse Marsch', 'Pt5zGv7Ku9', '1234567809', 'Head Coach', 7);
