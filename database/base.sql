DROP DATABASE IF EXISTS random_play_store;

CREATE DATABASE random_play_store;
USE random_play_store;

CREATE TABLE `games` (
  `g_id` int(255) AUTO_INCREMENT,
  `g_name` mediumtext NOT NULL,
  `genre` mediumtext NOT NULL,
  `release_date` date NOT NULL, 
  `description` mediumtext NOT NULL,
  PRIMARY KEY (g_id)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE `user_person` (
  `u_id` int(255) AUTO_INCREMENT,
  `u_name` mediumtext NOT NULL,
  `rank` mediumtext NOT NULL,
  `email` mediumtext NOT NULL,
  `password` mediumtext NOT NULL,
  PRIMARY KEY (u_id)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE `comments` (
	c_id int(255) PRIMARY KEY AUTO_INCREMENT,
	game_id int(255),
	user_id int(255),
	`comment_text` text NOT NULL,
	`comment_date` datetime NOT NULL,
	FOREIGN KEY (game_id) REFERENCES games(g_id) ,
	FOREIGN KEY (user_id) REFERENCES user_person(u_id)
);