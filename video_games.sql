CREATE TABLE Publisher
(
    pub_name VARCHAR(20) NOT NULL COLLATE NOCASE,
    headquarter VARCHAR(20),
    founded_date DATE,
    employee_count INT,
    PRIMARY KEY (pub_name)
);

CREATE TABLE Game
(
    game_name VARCHAR(20) NOT NULL COLLATE NOCASE,
    pub_name VARCHAR(20) NOT NULL COLLATE NOCASE,
    description VARCHAR(40),
    price FLOAT NOT NULL,
    release_date DATE NOT NULL,
    PRIMARY KEY (game_name, pub_name),
    FOREIGN KEY (pub_name) REFERENCES Publisher(pub_name)
);

CREATE TABLE Genre
(
    game_name VARCHAR(20) NOT NULL,
    pub_name VARCHAR(20) NOT NULL,
    genre VARCHAR(20)
        CHECK
            (genre in ('free to play', 'early access', 'action', 'adventure',
                        'casual', 'indie', 'massive multiplayer', 'racing',
                        'RPG', 'simulation', 'sports', 'strategy')
                 COLLATE NOCASE) NOT NULL,
    PRIMARY KEY (game_name, pub_name, genre),
    FOREIGN KEY (game_name, pub_name) REFERENCES Game(game_name, pub_name)
);

CREATE TABLE Player
(
    id VARCHAR(20) NOT NULL,
    name VARCHAR(20) NOT NULL,
    privacy_setting VARCHAR(10)
        CHECK (privacy_setting IN ('public', 'private') COLLATE NOCASE)
        DEFAULT 'private' NOT NULL
);

CREATE TABLE Ownership
(
    id VARCHAR(20) NOT NULL,
    game_name VARCHAR(20) NOT NULL,
    pub_name VARCHAR(20) NOT NULL,
    PRIMARY KEY (id, game_name, pub_name),
    FOREIGN KEY (id) REFERENCES Player(id),
    FOREIGN KEY (game_name, pub_name) REFERENCES Game(game_name, pub_name)
);

CREATE TABLE Playtime
(
    date DATE NOT NULL,
    hours INT CHECK (hours >= 0 AND hours <= 23) NOT NULL,
    minutes INT CHECK (minutes >= 0 AND minutes <= 59) NOT NULL,
    id VARCHAR(20) NOT NULL,
    game_name VARCHAR(20) NOT NULL,
    pub_name VARCHAR(20) NOT NULL,
    PRIMARY KEY (date, id, game_name, pub_name),
    FOREIGN KEY (id, game_name, pub_name) REFERENCES Ownership(id, game_name, pub_name)
);

CREATE TABLE FriendsList
(
    id1 VARCHAR(20) NOT NULL,
    id2 VARCHAR(20) NOT NULL,
    PRIMARY KEY (id1, id2),
    FOREIGN KEY (id1, id2) REFERENCES Player(id, id)
);

CREATE TABLE Review
(
    recommendation VARCHAR(3)
        CHECK (recommendation IN ('yes', 'no') COLLATE NOCASE) NOT NULL,
    visibility VARCHAR(7)
        CHECK (visibility IN ('public', 'private') COLLATE NOCASE)
        DEFAULT 'public' NOT NULL,
    date DATE NOT NULL,
    comment VARCHAR(40),
    id VARCHAR(20) NOT NULL,
    game_name VARCHAR(20) NOT NULL,
    pub_name VARCHAR(20) NOT NULL,
    PRIMARY KEY (id, game_name, pub_name),
    FOREIGN KEY (id) REFERENCES Player(id),
    FOREIGN KEY (game_name, pub_name) REFERENCES game(game_name, pub_name)
);

--Populate Publisher
INSERT INTO Publisher
VALUES ('Valve', 'Bellevue', '1996-08-24', 360);

INSERT INTO Publisher
VALUES ('Activision', 'Santa Monica', '1979-10-01', 9200);

INSERT INTO Publisher
VALUES ('Innersloth', 'Redmond', '2015-01-01', 8);

--Populate Game
INSERT INTO Game
VALUES ('CSGO', 'Valve', 'Counter-Strike: Global Offensive (CS: GO)', 0, '2012-8-21');

INSERT INTO Game
VALUES ('DOTA 2', 'Valve',
        'Millions of players worldwide enter battle as one of over a hundred Dota heroes.', 0, '2013-7-18');

INSERT INTO Game
VALUES ('COD:MW2', 'Activision', 'Call of Duty: Modern Warfare', 69.99, '2009-11-10');

INSERT INTO Game
VALUES ('Among Us', 'Innersloth', 'An online and local party game of teamwork and betrayal', 4.99, '2018-6-15');

--Populate Genre
INSERT INTO Genre
VALUES ('CSGO', 'Valve', 'free to play');

INSERT INTO Genre
VALUES ('CSGO', 'Valve', 'action');

INSERT INTO Genre
VALUES ('CSGO', 'Valve', 'strategy');

INSERT INTO Genre
VALUES ('DOTA 2', 'Valve', 'free to play');

INSERT INTO Genre
VALUES ('DOTA 2', 'Valve', 'strategy');

INSERT INTO Genre
VALUES ('DOTA 2', 'Valve', 'casual');

INSERT INTO Genre
VALUES ('COD:MW2', 'Activision', 'action');

INSERT INTO Genre
VALUES ('COD:MW2', 'Activision', 'strategy');

INSERT INTO Genre
VALUES ('Among Us', 'Innersloth', 'casual');

INSERT INTO Genre
VALUES ('Among Us', 'Innersloth', 'indie');

INSERT INTO Genre
VALUES ('Among Us', 'Innersloth', 'strategy');

--Populate Player--
INSERT INTO Player (id, name)
VALUES ('ABCD1234', 'PlayerOne');

INSERT INTO Player (id, name)
VALUES ('EFGH5678', 'FriendOne');

INSERT INTO Player
VALUES ('0112358', 'Fibonacci', 'public');

INSERT INTO Player
VALUES ('3141592', 'PieMan', 'private');

--Populate FriendsList--
INSERT INTO FriendsList
VALUES ('ABCD1234', 'EFGH5678');

INSERT INTO FriendsList
VALUES ('EFGH5678', '0112358');

--Populate Ownership--
INSERT INTO Ownership
VALUES ('ABCD1234', 'CSGO', 'Valve');

INSERT INTO Ownership
VALUES ('EFGH5678', 'CSGO', 'Valve');

INSERT INTO Ownership
VALUES ('0112358', 'CSGO', 'Valve');

INSERT INTO Ownership
VALUES ('3141592', 'DOTA 2', 'Valve');

INSERT INTO Ownership
VALUES ('EFGH5678', 'DOTA 2', 'Valve');

INSERT INTO Ownership
VALUES ('3141592', 'Among Us', 'Innersloth');

INSERT INTO Ownership
VALUES ('EFGH5678', 'Among Us', 'Innersloth');

INSERT INTO Ownership
VALUES ('EFGH5678', 'COD:MW2', 'Activision');

INSERT INTO Ownership
VALUES ('ABCD1234', 'COD:MW2', 'Activision');

-- Delete 'COD:MW2' from player with the id 'ABCD1234'
DELETE FROM Ownership
WHERE id = 'ABCD1234' AND game_name = 'COD:MW2' AND pub_name = 'Activision';

-- Populate Review
-- Populated with some dummy reviews, some players that left the review don't exist
INSERT INTO Review
VALUES ('yes', 'private', '2022-12-2', 'Very fun', 'ABCD1234', 'CSGO', 'Valve');

INSERT INTO Review
VALUES ('no', 'private', '2015-03-14', 'Not fun', '3141592', 'CSGO', 'Valve');

INSERT INTO Review
VALUES ('yes', 'private', '2017-01-12', 'Ok', '0112358', 'CSGO', 'Valve');

INSERT INTO Review
VALUES ('yes', 'private', '2022-12-2', NULL, '1', 'CSGO', 'Valve');

INSERT INTO Review
VALUES ('no', 'private', '2022-12-2', NULL, '2', 'CSGO', 'Valve');

INSERT INTO Review
VALUES ('no', 'public', '2015-09-30', 'Not fun', '3141592', 'DOTA 2', 'Valve');

INSERT INTO Review
VALUES ('yes', 'private', '2022-12-2', NULL, '1', 'DOTA 2', 'Valve');

INSERT INTO Review
VALUES ('no', 'public', '2022-12-2', 'ok', 'EFGH5678', 'Among Us', 'Innersloth');

INSERT INTO Review
VALUES ('no', 'private', '2022-12-2', NULL, '1', 'COD:MW2', 'Activision');

--Populate Playtime--
INSERT INTO Playtime
VALUES('2022-12-01', 1, 30, 'ABCD1234', 'CSGO', 'Valve');

INSERT INTO Playtime
VALUES('2022-12-02', 1, 45, 'ABCD1234', 'CSGO', 'Valve');

INSERT INTO Playtime
VALUES('2022-11-03', 3, 0, 'ABCD1234', 'CSGO', 'Valve');

INSERT INTO Playtime
VALUES('2022-11-03', 1, 25, 'EFGH5678', 'CSGO', 'Valve');

INSERT INTO Playtime
VALUES('2022-12-03', 1, 25, 'EFGH5678', 'CSGO', 'Valve');

INSERT INTO Playtime
VALUES('2019-03-04', 2, 15, 'EFGH5678', 'CSGO', 'Valve');

INSERT INTO Playtime
VALUES('2019-03-05', 2, 35, 'EFGH5678', 'CSGO', 'Valve');

INSERT INTO Playtime
VALUES('2022-12-03', 1, 25, 'EFGH5678', 'DOTA 2', 'Valve');

INSERT INTO Playtime
VALUES('2022-07-15', 2, 0, 'EFGH5678', 'Among Us', 'Innersloth');

INSERT INTO Playtime
VALUES('2015-09-26', 2, 0, '3141592', 'DOTA 2', 'Valve');

INSERT INTO Playtime
VALUES('2022-11-26', 2, 0, '3141592', 'DOTA 2', 'Valve');

INSERT INTO Playtime
VALUES('2015-09-26', 2, 0, '3141592', 'Among Us', 'Innersloth');

INSERT INTO Playtime
VALUES('2021-12-26', 0, 45, '0112358', 'Among Us', 'Innersloth');

-- update the visibility to public for player id '0112358' review on CSGO
UPDATE Review
SET visibility = 'public'
WHERE id = '0112358' AND game_name = 'CSGO' AND pub_name = 'Valve';

UPDATE Review
SET recommendation = 'yes'
WHERE id = 'EFGH5678' AND game_name = 'Among Us' AND pub_name = 'Innersloth';

-- a view of the sum all the playtime for each player
-- playtime is 0 if a player owns the game but never played it
CREATE VIEW TotalTime AS
SELECT t.id AS pid, name, game_name AS game, pub_name AS publisher,
       CAST((SUM(hours) * 60 + SUM(minutes)) / 60 AS INT) AS total_hours,
       CAST(SUM(hours) * 60 + SUM(minutes) - CAST((SUM(hours) * 60 + SUM(minutes)) / 60 AS INT) * 60 AS INT) AS total_mins
FROM Playtime t, Player p
WHERE t.id = p.id
GROUP BY pid, game, publisher
UNION
SELECT o.id AS pid, name, o.game_name AS game, o.pub_name AS publisher, 0 AS total_hours, 0 AS total_minutes
FROM Player p, Ownership o
LEFT JOIN Playtime t ON o.game_name = t.game_name and o.pub_name = t.pub_name
WHERE t.hours IS NULL and t.minutes IS NULL and p.id = o.id
ORDER BY pid, game;

-- shows the sum of playtime in the recent 2 weeks from 22/12/03 for each player
WITH Recent AS
(
    SELECT date, id, hours, minutes
    FROM Playtime t
    WHERE JULIANDAY('2022-12-03') - JULIANDAY(t.date) <= 14
)
SELECT r.id, p.name,
       CAST((SUM(hours) * 60 + SUM(minutes)) / 60 AS INT) AS two_weeks_hours,
       CAST(SUM(hours) * 60 + SUM(minutes) - CAST((SUM(hours) * 60 + SUM(minutes)) / 60 AS INT) * 60 AS INT) AS two_week_mins
FROM Recent r, Player p
WHERE p.id = r.id
GROUP BY r.id
ORDER BY r.id;

-- select all the friends of each player
SELECT id1 AS PlayerId, p1.name AS PlayerName, id2 AS FriendId, p2.name AS FriendsName
FROM FriendsList f, Player p1, Player p2
WHERE p1.id = f.id1 AND p2.id = f.id2
UNION
SELECT id2 AS PlayerId, p2.name AS PlayerName, id1 AS FriendId, p1.name AS FriendsName
FROM FriendsList f, Player p1, Player p2
WHERE p2.id = f.id2 AND p1.id = f.id1
GROUP BY PlayerId;

-- select all the reviews that is visible to player id 'EFGH5678' but not reviewed by himself
-- a review is visible to a player if the visibility is public or a player is friend with the reviewer
SELECT game_name, name AS player_name, recommendation, comment
FROM Review r, Player p
WHERE visibility = 'public' AND r.id = p.id AND r.id != 'EFGH5678'
UNION ALL
SELECT game_name, name AS player_name, recommendation, comment
FROM Review r, Player p, FriendsList f,
     (
         SELECT id1 AS id FROM FriendsList WHERE id2 = 'EFGH5678'
         UNION
         SELECT id2 AS id FROM FriendsList WHERE id1 = 'EFGH5678'
     ) i
WHERE visibility = 'private' AND r.id = p.id AND r.id IN (i.id)
GROUP BY game_name, pub_name;

-- show the overall rating of a game
-- >=80% 'yes' is 'very positive', >=60% 'yes' is 'mostly positive', >=40% yes is 'mixed
-- >=20% is 'mostly negative', else 'very negative'
CREATE VIEW Ratings AS
SELECT y.game_name, y.pub_name, SUM(yes_count) + SUM(no_count) AS num_reviews,
       CASE
           WHEN SUM(yes_count) / ((SUM(yes_count) + SUM(no_count)) * 1.0) >= 0.8 THEN 'very positive'
           WHEN SUM(yes_count) / ((SUM(yes_count) + SUM(no_count)) * 1.0) >= 0.6 THEN 'mostly positive'
           WHEN SUM(yes_count) / ((SUM(yes_count) + SUM(no_count)) * 1.0) >= 0.4 THEN 'mixed'
           WHEN SUM(yes_count) / ((SUM(yes_count) + SUM(no_count)) * 1.0) >= 0.2 THEN 'mostly negative'
           ELSE 'very negative' END AS rating
FROM
    (
        SELECT game_name, pub_name, COUNT(1) as yes_count, 0 AS no_count
        FROM Review
        WHERE recommendation = 'yes'
        GROUP BY game_name, pub_name
        UNION
        SELECT game_name, pub_name, 0 AS yes_count, COUNT(1) as no_count
        FROM Review
        WHERE recommendation = 'no'
        GROUP BY game_name, pub_name
    ) y
GROUP BY y.game_name, y.pub_name;

-- select games that have a positive rating
SELECT * FROM Ratings
WHERE rating = 'very positive' OR rating = 'mostly positive';

-- select all of the players who owns the game 'Among Us'
SELECT p.name, p.id
FROM Ownership o, Player p
WHERE o.id = p.id AND o.pub_name = 'Innersloth' AND o.game_name = 'Among Us';

-- select the games that player with the id 'EFGH5678' owns and order by the number of hours played
SELECT game, publisher, total_hours, total_mins
FROM TotalTime
WHERE pid = 'EFGH5678'
ORDER BY total_hours DESC, total_mins DESC;

-- select the average playtime for all players that own 'Among Us'
SELECT
    game, publisher,
    CAST((AVG(total_hours) * 60 + AVG(total_mins)) / 60 AS INT) AS Avg_hours,
    CAST(AVG(total_hours) * 60 + AVG(total_mins) - (CAST((AVG(total_hours) * 60 + AVG(total_mins)) / 60 AS INT) * 60) AS INT) AS Avg_mins
FROM TotalTime
WHERE game = 'Among Us' AND publisher = 'Innersloth';

-- select the game with the maximum price
SELECT * FROM GAME WHERE price = (SELECT MAX(price) FROM Game);

-- update the time played for the player with id '0112358' who played 'Among Us' on '2021-12-26'
UPDATE Playtime
SET minutes = 30
WHERE id = '0112358' AND game_name = 'Among Us' AND date = '2021-12-26';

-- show all the players and number of games they owned who have their profiles set to public or is a friend of player id 'EFGH5678'
SELECT name, COUNT(1) AS GamesOwned
FROM Player p, Ownership o
WHERE p.id = o.id AND p.privacy_setting = 'public'
GROUP BY p.id
UNION
SELECT name, COUNT(1) AS GamesOwned
FROM Player p, Ownership o,
     (
         SELECT id1 AS id FROM FriendsList WHERE id2 = 'EFGH5678'
         UNION
         SELECT id2 AS id FROM FriendsList WHERE id1 = 'EFGH5678'
     ) i
WHERE p.id = o.id AND p.privacy_setting = 'private' AND o.id in (i.id)
GROUP BY p.id;