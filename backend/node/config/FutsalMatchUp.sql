CREATE DATABASE IF NOT EXISTS futsalMatchUp;
USE futsalMatchUp;

CREATE TABLE IF NOT EXISTS teams (
    team_id INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS stadiums (
    stadium_id INT AUTO_INCREMENT PRIMARY KEY,
    stadium_name VARCHAR(100),
    stadium_location VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS players (
    user_id INT AUTO_INCREMENT NOT NULL UNIQUE PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100),
    phone_no VARCHAR(100),
    age INT,
    player_skill_rating DOUBLE,
    player_sportsmanship_rating DOUBLE,
    player_overall_rating DOUBLE,
    player_rated_times INT,
    player_city VARCHAR(100),
    player_availability BOOLEAN,
    player_position VARCHAR(50),
    team_id INT,
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

CREATE TABLE IF NOT EXISTS managers (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100),
    password VARCHAR(100),
    phone_no VARCHAR(100),
    manager_position VARCHAR(100),
    stadium_id INT, 
    FOREIGN KEY (stadium_id) REFERENCES stadiums(stadium_id) 
);

CREATE TABLE IF NOT EXISTS team_members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    player_id INT,
    FOREIGN KEY (team_id) REFERENCES teams(team_id),
    FOREIGN KEY (player_id) REFERENCES players(user_id)
);

CREATE TABLE IF NOT EXISTS stadium_schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    stadium_id INT,
    start_date_time DATETIME,
    end_date_time DATETIME,
    FOREIGN KEY (stadium_id) REFERENCES stadiums(stadium_id)
);

CREATE TABLE IF NOT EXISTS bookings (
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
INSERT INTO players (username, password, phone_no, age, player_skill_rating, player_sportsmanship_rating, player_overall_rating, player_rated_times, player_city, player_availability, player_position, team_id) VALUES
('LeoMessi', '$2b$10$26Et5qCV1SFhDF3kGQNmh.iG3/eL8PuJNuP32EWAlaK7IUpGlCcPe', '1234567890', 34, 3.76, 4.28, 4.02, 10, 'Barcelona', TRUE, 'Forward', 1),
('CristianoRonaldo', '$2b$10$a75IQdck5mkYV624PIpj6OFeeF51/aDIj/ooBiXTzQTiFKWp5TZAG', '1234567891', 37, 1.94, 0.35, 1.14, 10, 'Turin', TRUE, 'Forward', 5),
('Neymar Jr', '$2b$10$p2eHWTMsuNPe2LOljVW0DeZY3lF7kdYY8JrTX4j5A032bJi9JdV7C', '1234567892', 30, 4.12, 3.89, 4.00, 10, 'Paris', TRUE, 'Forward', 6),
('LionelMessi', '$2b$10$kKu/ZnRJXa1qwZb7O/85e.JoKPGm55vOBvPeRxARaVnxvZ4opzK3G', '1234567893', 35, 0.25, 3.64, 1.94, 10, 'Barcelona', TRUE, 'Forward', 1),
('Kevin De Bruyne', '$2b$10$ZFscgOFgM4K2QvS.k4BNkOK9UUn3XkBpS7P2oT4Cv7uEABD8.sKoq', '1234567894', 30, 3.84, 2.11, 2.98, 10,'Manchester', TRUE, 'Midfielder', 8),
('Sergio Ramos', '$2b$10$YG7JY4YMJmoTMJwluHFAGeFqi3iO571b1dgEswjLIc5geW7hZYw8i', '1234567895', 35, 0.97, 2.22, 1.59, 10, 'Madrid', TRUE, 'Defender', 2),
('Robert Lewandowski', '$2b$10$wy2uxQsZw4yQCj6m8VHb0OpmzlA6//GJ.3BQ/FP5oJOzdl3qT41fC', '1234567896', 33, 0.73, 4.69, 2.71, 10, 'Munich', TRUE, 'Forward', 7),
('Mohamed Salah', '$2b$10$YiK6XhdWbWZKnoWkOk5kleOH8kcfviVSExiYKct7ipMM1SNTqSy4S', '1234567897', 29, 0.53, 0.92, 0.72, 10, 'Liverpool', TRUE, 'Forward', 4),
('Harry Kane', '$2b$10$qW8hCpe3QTmysU.NyvgRkO/E4GL9g3RP/hI7zr03CU1XMRgOsBhXa', '1234567898', 28, 2.38, 1.66, 2.02, 10, 'London', TRUE, 'Forward', 12),
('Virgil van Dijk', '$2b$10$YY7tUrlZjBQCBB40ybjQ5ONlfVrWf4baXwhvMbm10r4K1JAP28jgW', '1234567899', 30, 2.43, 2.84, 2.63, 10, 'Liverpool', TRUE, 'Defender', 4),
('Alisson Becker', '$2b$10$koNGv/zBTLhxjnCl/981G.tTYVTgGPJgrx5Wlx9E1H9bfgeBKKI/C', '1234567800', 29, 3.41, 3.76, 3.45, 10, 'Liverpool', TRUE, 'Goalkeeper', 4),
('Kylian Mbappe', '$2b$10$2bplwrhlP3hyicBsxiRNZOXKRjo0/VkwqMEMHfesvaNDrpM/kdVzS', '1234567801', 23, 0.91, 0.57, 0.74, 10, 'Paris', TRUE, 'Forward', 6),
('Jan Oblak', '$2b$10$ZHNQu5ZzwSvJNqt6J14Vn..ZidN/eIq7jPlvDC.T4HLF1C0Ux28Y.', '1234567802', 29, 3.56, 2.05, 2.81, 10, 'Madrid', TRUE, 'Goalkeeper', 2),
('Bruno Fernandes', '$2b$10$HTc117df9g3pkLETBv3Jp.XJ.WsVHVY4O4JnLjGavSnzZLN5XWi62', '1234567803', 27, 1.14, 0.08, 0.61, 10, 'Manchester', TRUE, 'Midfielder', 8),
('Joshua Kimmich', '$2b$10$ihcyUM0fAiEaYREeivTy5udJsshiqnX4SklyvY1VqFyaNmcD6cC7O', '1234567804', 27, 0.32, 0.75, 0.53, 10, 'Munich', TRUE, 'Midfielder', 7),
('Romelu Lukaku', '$2b$10$etlKOhaNCaNAmsZ1E1/NfOonSJnyU.D4MBdl9vgB8UviDqttoa8Di', '1234567805', 28, 4.86, 0.20, 2.53, 10, 'Milan', TRUE, 'Forward', 10),
('Trent Alexander-Arnold', '$2b$10$FhPKq01iYQYWgYD3JpaRWuhADTUPa5paeO3nbgNZghAGXCojXToe2', '1234567806', 23, 4.17, 0.44, 2.30, 10, 'Liverpool', TRUE, 'Defender', 4),
('Jadon Sancho', '$2b$10$gEU0fsTEkT4Ol0DN5O30yOqVEbYkYTT4I7uX3KmPyA1qm0JvgaP1e', '1234567807', 22, 2.98, 3.11, 3.05, 10, 'Dortmund', TRUE, 'Forward', 13),
('Ederson', '$2b$10$KybkVidx50fSUBY3.Ahm0e0fEBUHeHeSRjKfVrpmWz85sBYSVEhMC', '1234567808', 28, 3.99, 3.60, 3.80, 10, 'Manchester', TRUE, 'Goalkeeper', 8),
('Luis Suarez', '$2b$10$4VdLpJ6qk6gdwGcCHKxzT.akGkc7pgKpuVFTjIPoclW9yHRqo6s6m', '1234567809', 35, 0.86, 2.26, 1.56, 10, 'Madrid', TRUE, 'Forward', 2);


-- Insert 20 values into the 'managers' table
INSERT INTO managers (username, password, phone_no, manager_position, stadium_id) VALUES
('Pep Guardiola', '$2b$10$smL7OBVr05nzZT9y.r867OXV2ZaPEUXkNNOMSw9jjZBMYqxQhSDsK', '1234567890', 'Head Coach', 8),
('Jurgen Klopp', '$2b$10$hjwyoSHp75AE2KxIGzks6OTe8Cn4RmpQt8xb9ZIScTcBJdPMWJExm', '1234567891', 'Head Coach', 4),
('Zinedine Zidane', '$2b$10$QcDeM9RN6Tp7nSzhbRuKkOB5SXaMp.wIFz9ugPrwi4mCwiMrLc03G', '1234567892', 'Head Coach', 2),
('Diego Simeone', '$2b$10$WdT3Q7E7aMQDxww8JbzTBeln.drTQzHzcHw1reGuObM264.tag7d2', '1234567893', 'Head Coach', 15),
('Thomas Tuchel', '$2b$10$JCz6ewihXRvgAD.qKIBIoem7CVv4HkyajPd3BVbYXYlCthQMAT.Ma', '1234567894', 'Head Coach', 9),
('Antonio Conte', '$2b$10$d9i5TwVvpVTMizQNeHfALusFyRfjW1Xi/Pus6NikQQTfLYUm4zejW', '1234567895', 'Head Coach', 10),
('Mauricio Pochettino', '$2b$10$WHIKGvl8.coXw5tEr6ZcKOBvqUjW62zqgXModbNac98r/EUeMN0He', '1234567896', 'Head Coach', 6),
('Carlo Ancelotti', '$2b$10$VJtQa4YcWolBut45CKnvj.Lj0gktwFeDH.v.lRpaPJDNpg1eVB6kW', '1234567897', 'Head Coach', 1),
('Julian Nagelsmann', '$2b$10$v7ajcBrtEFd7DmyQeLRCR.R9rxU51utRxxi0J4JjX6Yhjp1/5KoDq', '1234567898', 'Head Coach', 13),
('Ole Gunnar Solskjaer', '$2b$10$O7Au7GxglVRb0SGLUYPgEuOfRUGFYEAV6SFHQrXm.2aE9ubFGMDsa', '1234567899', 'Head Coach', 3),
('Roberto Mancini', '$2b$10$WYcvxmoqzp1Xpr284x3Fr.yZdvdJTylf2TINSm0N.Xi0q7vQPHJ4S', '1234567800', 'Head Coach', 12),
('Marcelo Bielsa', '$2b$10$0TlognM/CBPwUWIw8/h7oe5f4oAOStIk7ipDkfhvYOEuJKeUaV56.', '1234567801', 'Head Coach', 20),
('Erik ten Hag', '$2b$10$UVGqHDM6nS70COAs01Vq6O.cVv7UoWmRB20q2GFAvqxGwRATRkx/6', '1234567802', 'Head Coach', 17),
('Rudi Garcia', '$2b$10$GVBe9YX7FiyqSNfjTgIFxeQrxAK6uwUn6.1vSkM46oiak4pYMtvhe', '1234567803', 'Head Coach', 19),
('Jose Mourinho', '$2b$10$77sUokC8FaItw6k9P.3Wm.c3VXh.dGMErel1CGe7/WQeZGSkq95UW', '1234567804', 'Head Coach', 11),
('Gian Piero Gasperini', '$2b$10$MsB3OVulfuYzQf0Rw2f4reYt6aeaR2OOq0Fz5fCGRUH3Miho/riPi', '1234567805', 'Head Coach', 16),
('Ralf Rangnick', '$2b$10$64X8VNRh0RD.XmPibrDf0uyDDdyofhMORBZ/E/n1W2HZBdqyjI0mO', '1234567806', 'Head Coach', 5),
('Maurizio Sarri', '$2b$10$gxHQnG7jJM.flf9a6bAhPuQ8AUuaZx6Mmt06xtdOCt4a7uDn61MA.', '1234567807', 'Head Coach', 14),
('Lucien Favre', '$2b$10$XpCyel6r6TxujDgnxeXzl.P5JkjmpHRfRBSjy2yY0ByU.WDiOqIAq', '1234567808', 'Head Coach', 18),
('Jesse Marsch', '$2b$10$Q1zGBhvFUjF6nYBUNIvqKevPtmKDLT58uLcxlwwItpS6ZLcfE8Rvi', '1234567809', 'Head Coach', 7);

-- Insert 10 values into the 'bookings' table
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
