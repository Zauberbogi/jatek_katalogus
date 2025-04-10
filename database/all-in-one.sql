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
  `rented_game_id` int(255),
  `rental_date` date,
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


INSERT INTO `games` (`id`, `name`, `genre`, `release_date`, `description`) VALUES
(1, 'Warframe', 'Looter Shooter','2012-03-25','A third person shooter game made by Digital Extremes where you collect resources and fight factions as an independent fighter solo or in a team up to 4 people.'),
(2, 'Team Fortress 2', 'FPS','2007-10-10','A first person class based shooter (nowadays being called a hero shooter) made by Valve studio, this game was included in the Orange Box game bundle and the game went free to play (F2P) in 2011.'),
(3, 'Need For Speed Underground', 'Racing','2003-11-17','The first PC mainline Need For Speed developed by Black Box Studio. In the game you are illegally race on the streets at night, there are circuit, drag, drift, lap knockout (3 lap circuit races, where each racer gets dropped out) and sprint races.'),
(4, 'osu!', 'Ritmus','2007-09-16','One of the most popular rythm game in the world on PC made by Dean Herbert, with community made maps and UIs. Also there are numerous amount of game modes and modifiers, such as osu(clicking circles and using the mouse to move your cursor) and osu mania(using either 4 key or 8 key to hit the notes) and modifiers such as flashlight (you only can see in a limited area around your view) and hard rock (flipping the nodes on the x-axis in standard osu)'),
(5, 'The Forest', 'Survival','2014-05-30','Made by Endnight Games Ltd. As the lone survivor of a passenger jet crash, you find yourself in a mysterious forest battling to stay alive against a society of cannibalistic mutants. Build, explore, survive in this terrifying first person survival horror simulator. (from Steam page)'),
(6, 'Fortnite', 'Battle Royal','2017-07-21','Fortnite is an online video game and game platform developed by Epic Games and released in 2017. It is available in six distinct game mode versions that otherwise share the same general gameplay and game engine: Fortnite Battle Royale, a free-to-play battle royale game in which up to 100 players fight to be the last person standing (from Wikipedia)'),
(7, 'Baldur’s Gate III', 'RPG','2023-08-03','Made by Larian Studios Gather your party and return to the Forgotten Realms in a tale of fellowship and betrayal, sacrifice and survival, and the lure of absolute power. Mysterious abilities are awakening inside you, drawn from a mind flayer parasite planted in your brain. Resist, and turn darkness against itself. Or embrace corruption, and become ultimate evil. From the creators of Divinity: Original Sin 2 comes a next-generation RPG, set in the world of Dungeons & Dragons. (from Steam page)'),
(8, 'Civilization V', 'Strategy','2010-09-21','Made by Firaxis Games In Civilization V, the player leads a civilization from prehistoric times into the future on a procedurally generated map, attempting to achieve one of a number of different victory conditions through research, exploration, diplomacy, expansion, economic development, government and military conquest. The game is based on an entirely new game engine with hexagonal tiles instead of the square tiles of earlier games in the series. (from Wikipedia)'),
(9, 'Fifa 13', 'Sport','2012-09-25','FIFA 13 is a football simulation video game developed by EA Canada. The game features a decent variety of leagues.'),
(10, 'Slender: The Eight Pages', 'Horror','2012-08-26','The game was originally titled Slender, is a short first-person survival horror game based on the Slender Man, an infamous creepypasta (online horror story). It was developed by independent developer Mark J. Hadley. In the game the defenseless player must collect eight pages scattered around a dark forest while avoiding the Slender Man.'),
(11, 'Sims 4', 'Simulation','2014-09-2','The Sims 4 is a social simulation game developed by Maxis and published by Electronic Arts. As with previous games in the series, The Sims 4 allows players to create and customize characters called .Sims., build and furnish their homes, and simulate their daily life across various in-game regions.');
(NULL, 'Beat Saber', 'Rythm', '2018-05-01', 'Beat Saber is a VR rhythm game where you slash the beats of adrenaline-pumping music as they fly towards you, surrounded by a futuristic world. '), 
(NULL, 'Call of Duty: Black Ops', 'FPS', '2010-11-09', 'The biggest first-person action series of all time and the follow-up to critically acclaimed Call of Duty®: Modern Warfare 2 returns with Call of Duty®: Black Ops. ');
(NULL, 'Borderlands Bundle', 'Looter Shooter', '2009-10-30', 'The Borderlands game series, through the very beginnings to the very end so far (Borderlands 1 to Borderlands 3)'), 
(NULL, 'Sims 3', 'Simulation', '2009-06-02', 'The Sims 3: Create the perfect world with full customization at your fingertips. Refine personalities and help fulfill destinies. ');
(NULL, 'Need For Speed: Most Wanted', 'Racing', '2005-12-02', 'Most Wanted focuses on street racing-oriented gameplay involving a selection of events and racing circuits found within the fictional city of Rockport. The game\'s main story involving players taking on the role of a street racer who must compete against 15 of the city\'s most elite street racers to become the \"most wanted\" racer of the group. In the process, they will seek revenge against one of the groups who took their car, and develop a feud with the city\'s police department. The game brought in many notable improvements and additions over other entries in the series, its major highlight being more in-depth police pursuits. Certain editions of the game were packaged with the ability for online multiplayer gaming. ');
	

INSERT INTO `user_person` (`id`, `name`, `rank`, `email`, `password`, `rented_game_id`, `rental_date`) VALUES
(1, 'Zauber Boglárka', 'Admin', 'zauberboglarkaWP@gmail.com', 'ruberduckies', NULL, NULL),
(2, 'György Péter', 'Admin', 'gyorgy.peter.WP@gmail.com', 'MechaMachines', NULL, NULL),
(3, 'Gipsz Jakab', 'Tester', 'gipszjakab@gmail.com', 'gypszjakib', NULL, NULL),
(4, 'Magneti Marelli', 'Tester', 'MagnetiMarelli@MMWPsuper.com', 'mmm-Magneti', NULL, NULL),
(5, 'Wise', 'Tester', 'P.WiseP@interknot.hk', 'HellaWise', NULL, NULL),
(6, 'Belle', 'Tester', 'P.BelleP@interknot.hk', 'SlayinBelle', NULL, NULL),
(7, 'ARTA', 'Tester', 'ARTA.supergt@yahoo.jp', 'ARTAstic', NULL, NULL),
(8, 'Inner Circle', 'Tester', 'innercircleband@bing.com', 'bobmarleybest', NULL, NULL),
(9, 'Rebbeca Ford', 'User', 'rebbford@blsky.social.com', 'warframelotusmommy', NULL, NULL),
(10, 'Leopard 2A7 MTB', 'User', 'rheinmetallstrongest@germansteel.de', 'DM-63', NULL, NULL),
(11, 'Tiger Shark', 'User', 'adoptmepleaseihaveause@NorthropWP.us', 'imbetterthanthef16', NULL, NULL);

INSERT INTO `ratings` (`id`, `rating`, `game_id`, `user_id`) VALUES
(1,5,1,2),
(2,5,3,2);

INSERT INTO `comments` (`id`,`game_id`,`user_id`,`comment_text`,`comment_date`) VALUES
(1,1,2,'very good game, me likes.','2024-11-29 20:00'),
(2,5,1,'szeretem a játékot, jó memoriáim vannak róla','2024-11-30 14:00'),
(3,5,1,'Gyerekkorom kedvenc versenyzős játéka, mindig vissza jövök és játszok vele.','2025-01-10 13:15:39'),
(4,9,7,'I dislike this game because of its predatory microtransactions.','2025-01-10 13:41:41')
