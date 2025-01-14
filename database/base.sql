DROP DATABASE IF EXISTS random_play_store;

CREATE DATABASE random_play_store;
USE random_play_store;

CREATE TABLE `games` (
  `id` int(255) AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `genre` varchar(50) NOT NULL,
  `release_date` date NOT NULL, 
  `description` text NOT NULL,
  PRIMARY KEY (id)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE `user_person` (
  `id` int(255) AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `rank` varchar(40) NOT NULL,
  `email` text NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (id)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE `comments` (
	id int(255) PRIMARY KEY AUTO_INCREMENT,
	game_id int(255),
	user_id int(255),
	`comment_text` text NOT NULL,
	`comment_date` datetime NOT NULL,
	FOREIGN KEY (game_id) REFERENCES games(id),
	FOREIGN KEY (user_id) REFERENCES user_person(id)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE `ratings` (
	id int(255) PRIMARY KEY AUTO_INCREMENT,
	rating int(1),
	game_id int(255),
	user_id int(255),
	FOREIGN KEY (game_id) REFERENCES games(id),
	FOREIGN KEY (user_id) REFERENCES user_person(id)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
