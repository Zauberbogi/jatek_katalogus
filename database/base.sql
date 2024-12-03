DROP DATABASE IF EXISTS random_play_store;

CREATE DATABASE random_play_store;
USE random_play_store;

CREATE TABLE `games` (
  `id` int(255) AUTO_INCREMENT,
  `name` mediumtext NOT NULL,
  `genre` mediumtext NOT NULL,
  `release_date` date NOT NULL, 
  `description` mediumtext NOT NULL,
  PRIMARY KEY (id)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE `user_person` (
  `id` int(255) AUTO_INCREMENT,
  `name` mediumtext NOT NULL,
  `rank` mediumtext NOT NULL,
  `email` mediumtext NOT NULL,
  `password` mediumtext NOT NULL,
  PRIMARY KEY (id)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE `comments` (
	id int(255) PRIMARY KEY AUTO_INCREMENT,
	game_id int(255),
	user_id int(255),
	`comment_text` text NOT NULL,
	`comment_date` datetime NOT NULL,
	FOREIGN KEY (game_id) REFERENCES games(id) ,
	FOREIGN KEY (user_id) REFERENCES user_person(id)
);