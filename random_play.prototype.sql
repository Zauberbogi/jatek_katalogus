SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE random_play;


CREATE TABLE `games` (
  `id` int(255) DEFAULT NULL,
  `g_name` varchar(50) DEFAULT NULL,
  `genre` varchar(20) DEFAULT NULL
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;



INSERT INTO `games` (`id`, `g_name`, `genre`) VALUES
(1, 'Warframe', 'Looter Shooter'),
(2, 'Team Fortress 2', 'FPS'),
(3, 'Need For Speed Underground', 'Racing'),
(4, 'osu!', 'Ritmus'),
(5, 'The Forest', 'Survival'),
(6, 'Fortnite', 'Battle Royal'),
(7, 'Final Fantasy XIV', 'RPG'),
(8, 'Civilization V', 'Strategy'),
(9, 'Fifa 13', 'Sport'),
(10, 'Slenderman', 'Horror'),
(11, 'Sims 4', 'Simulation');


CREATE TABLE `user_person` (
  `u_id` int(255) DEFAULT NULL,
  `u_name` varchar(100) DEFAULT NULL,
  `rank` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;



INSERT INTO `user_person` (`u_id`, `u_name`, `rank`, `email`, `password`) VALUES
(1, 'Zauber Boglárka', 'Admin', 'zauberboglarkaWP@gmail.com', 'ruberduckies'),
(2, 'György Péter', 'Admin', 'gyorgy.peter.WP@gmail.com', 'MechaMachines'),
(3, 'Gipsz Jakab', 'Tester', 'gipszjakab@gmail.com', 'gypszjakib'),
(4, 'Magneti Marelli', 'Tester', 'MagnetiMarelli@MMWPsuper.com', 'mmm-Magneti'),
(5, 'Wise', 'Tester', 'P.WiseP@interknot.hk', 'HellaWise'),
(6, 'Belle', 'Tester', 'P.BelleP@interknot.hk', 'SlayinBelle'),
(7, 'ARTA', 'Tester', 'ARTA.supergt@yahoo.jp', 'ARTAstic'),
(8, 'Inner Circle', 'Tester', 'innercircleband@bing.com', 'bobmarleybest'),
(9, 'Rebbeca Ford', 'User', 'rebbford@blsky.social.com', 'warframelotusmommy'),
(10, 'Leopard 2A7 MTB', 'User', 'rheinmetallstrongest@germansteel.de', 'DM-63'),
(11, 'Tiger Shark', 'User', 'adoptmepleaseihaveause@NorthropWP.us', 'imbetterthanthef16');