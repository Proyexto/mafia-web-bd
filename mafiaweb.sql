-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-11-2023 a las 02:07:10
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `mafiaweb`
--
CREATE DATABASE IF NOT EXISTS `mafiaweb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `mafiaweb`;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `addRooms` (IN `roomId` VARCHAR(20), IN `statusR` VARCHAR(20))   BEGIN 
INSERT INTO room VALUES (roomId, 1, statusR);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addUser` (IN `userName` VARCHAR(12), IN `userEmail` VARCHAR(60), IN `pasword` VARCHAR(60), IN `id_Img` INT(11))   BEGIN
	INSERT INTO users
	VALUES (NULL, userName, userEmail, pasword, id_Img, NULL);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delUser` (IN `userName` VARCHAR(12))   begin 
UPDATE users
set users.del_at = CURRENT_DATE()
where users.username = userName;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `chat_room`
--

CREATE TABLE `chat_room` (
  `id` int(255) NOT NULL,
  `id_room` varchar(30) NOT NULL,
  `id_user` bigint(20) NOT NULL,
  `msg` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `image`
--

CREATE TABLE `image` (
  `id` int(11) NOT NULL,
  `URL` varchar(40) NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `image`
--

INSERT INTO `image` (`id`, `URL`, `width`, `height`) VALUES
(1, 'efdbeg3r', 11, 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `room`
--

CREATE TABLE `room` (
  `id` varchar(60) NOT NULL,
  `cant_us` int(10) NOT NULL,
  `status` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `room`
--

INSERT INTO `room` (`id`, `cant_us`, `status`) VALUES
('jbjdhsiofhss', 1, 'ABIERTA');

--
-- Disparadores `room`
--
DELIMITER $$
CREATE TRIGGER `delRoom` AFTER UPDATE ON `room` FOR EACH ROW DELETE FROM room 
WHERE cant_us = 0
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id_user` bigint(20) NOT NULL,
  `email` varchar(60) NOT NULL,
  `username` varchar(12) NOT NULL,
  `pass` varchar(60) NOT NULL,
  `id_img` int(11) NOT NULL,
  `del_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id_user`, `email`, `username`, `pass`, `id_img`, `del_at`) VALUES
(1, 'pene', 'vinagre', '*9E735C258', 1, NULL),
(2, 'pene', 'abuelo', '*9E735C258', 3, NULL),
(3, 'Juancito', 'juancitomail', 'holajuan123', 4, '2023-11-14');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `chat_room`
--
ALTER TABLE `chat_room`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_room` (`id_room`),
  ADD KEY `id_user` (`id_user`);

--
-- Indices de la tabla `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `id_img` (`id_img`) USING BTREE;

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `chat_room`
--
ALTER TABLE `chat_room`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `image`
--
ALTER TABLE `image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id_user` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `chat_room`
--
ALTER TABLE `chat_room`
  ADD CONSTRAINT `chat_room_ibfk_1` FOREIGN KEY (`id_room`) REFERENCES `room` (`id`),
  ADD CONSTRAINT `chat_room_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);

--
-- Filtros para la tabla `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `noAction` FOREIGN KEY (`id`) REFERENCES `users` (`id_img`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
