-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-03-2024 a las 13:56:57
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `metro_sto`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `active_drivers`
--

CREATE TABLE `active_drivers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `driver_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `drivers`
--

CREATE TABLE `drivers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `drivers`
--

INSERT INTO `drivers` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Carlos Mendoza', 0, '2024-03-27 09:55:02', '2024-03-27 12:55:02'),
(2, 'Luis Martinez', 0, '2024-03-27 09:55:02', '2024-03-27 12:55:02'),
(3, 'Jose Luiz', 0, '2024-03-27 09:55:02', '2024-03-27 12:55:02'),
(4, 'Elvis Gonzales', 0, '2024-03-27 09:55:02', '2024-03-27 12:55:02'),
(5, 'Pedro Sanchez', 0, '2024-03-27 09:55:02', '2024-03-27 12:55:02'),
(6, 'Amanda Mercedes', 0, '2024-03-27 09:55:02', '2024-03-27 12:55:02'),
(7, 'Maria Mendez', 0, '2024-03-27 09:55:02', '2024-03-27 12:55:02');

--
-- Disparadores `drivers`
--
DELIMITER $$
CREATE TRIGGER `updated_active_drivers` AFTER UPDATE ON `drivers` FOR EACH ROW BEGIN
    IF NEW.status = 1 THEN
        INSERT INTO active_drivers (driver_id) VALUES (NEW.id);
    ELSE
        DELETE FROM active_drivers WHERE driver_id = NEW.id;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lines`
--

CREATE TABLE `lines` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(10) NOT NULL,
  `color` varchar(15) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `lines`
--

INSERT INTO `lines` (`id`, `name`, `color`, `created_at`, `updated_at`) VALUES
(1, 'Línea 1', 'Roja', '2024-03-27 12:29:16', '2024-03-27 12:29:16'),
(2, 'Línea 2', 'Amarilla', '2024-03-27 12:29:16', '2024-03-27 12:29:16'),
(3, 'Línea 3', 'Marrón', '2024-03-27 12:29:16', '2024-03-27 12:29:16'),
(4, 'Línea 4', 'Azul', '2024-03-27 12:29:16', '2024-03-27 12:29:16'),
(5, 'Línea 5', 'Verde', '2024-03-27 12:29:16', '2024-03-27 12:29:16'),
(6, 'Línea 6', 'Rosado', '2024-03-27 12:29:16', '2024-03-27 12:29:16');

--
-- Disparadores `lines`
--
DELIMITER $$
CREATE TRIGGER `update_updated_at_field` BEFORE UPDATE ON `lines` FOR EACH ROW SET  NEW.updated_at = NOW()
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lines_stations`
--

CREATE TABLE `lines_stations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `line_id` bigint(20) UNSIGNED NOT NULL,
  `station_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `locations`
--

CREATE TABLE `locations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `station_id` bigint(20) UNSIGNED NOT NULL,
  `location` point NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `locations`
--

INSERT INTO `locations` (`id`, `station_id`, `location`, `created_at`, `updated_at`) VALUES
(1, 1, 0x0000000001010000002334dd465eae51c0285e0ab4e0b840c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(2, 2, 0x0000000001010000002334dd465eae51c0285e0ab4e0b840c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(3, 3, 0x0000000001010000003b62e3b06aae51c0b5a4a31cccb940c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(4, 4, 0x00000000010100000002caf0e9fbad51c0d69a9c908cba40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(5, 5, 0x000000000101000000f9275d9f5ead51c02f3c8ace8dba40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(6, 6, 0x00000000010100000019d29794f1ac51c076feedb25fba40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(7, 7, 0x00000000010100000069e388b578ac51c060adda3521ba40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(8, 8, 0x000000000101000000375c9a1114ac51c0b680d07af8b940c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(9, 9, 0x000000000101000000d9a89894ccad51c0cd3747c263ba40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(10, 10, 0x000000000101000000ae77c94972ab51c01a2e1796e4b940c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(11, 11, 0x000000000101000000e91093cbdaaa51c03dadeccc4eb940c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(12, 12, 0x000000000101000000458e63da6daa51c0f8e0b54b1bb940c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(13, 13, 0x00000000010100000097981d9812aa51c00ef96706f1b840c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(14, 14, 0x0000000001010000000b84f81bc8a951c09a8933d0c6b840c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(15, 15, 0x000000000101000000786ae4a97da951c0eb7420eba9b840c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(16, 16, 0x000000000101000000922f57f528a951c09dd843fb58b840c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(17, 17, 0x000000000101000000d39453f1b5a851c073d87dc7f0b740c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(18, 18, 0x00000000010100000062a9e452cba751c0a01b9ab2d3b640c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(19, 19, 0x0000000001010000005d7bb0d61aa751c0b477a11408b640c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(20, 20, 0x00000000010100000001906edf7ea651c0a764ef7b8ab540c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(21, 21, 0x000000000101000000ef377fb850a651c00f6c4bd356b540c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(22, 22, 0x00000000010100000086b9933ee3a551c0fcc808032ab540c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(23, 23, 0x0000000001010000002b29c12c7ea551c05dfe43faedb440c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(24, 24, 0x0000000001010000000a12dbdd83a451c0ab7e00ad54b440c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(25, 25, 0x0000000001010000008ba3175ac2a351c0d2df4be141b440c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(26, 26, 0x000000000101000000d580f7440da351c0c15774eb35b440c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(27, 27, 0x0000000001010000001c6ca0af8fa951c0408864c8b1b040c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(28, 28, 0x000000000101000000ed985f7248a951c0f719bc5411b240c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(29, 29, 0x0000000001010000004dadad8e52a951c016e75e16c9b240c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(30, 30, 0x0000000001010000008e82966453a951c09ed32cd0eeb340c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(31, 31, 0x000000000101000000772167ab5ca951c0618a7269fcb440c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(32, 32, 0x000000000101000000430c2a6071a951c036c98ff815b640c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(33, 34, 0x0000000001010000003a90f5d4eaa951c09780a9b063b740c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(34, 35, 0x0000000001010000007e35070866aa51c05b35199f13b840c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(35, 36, 0x0000000001010000001a9cd20b88aa51c02e8d5f7825b940c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(36, 37, 0x0000000001010000009004d0de4faa51c0cdbc6603fab940c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(37, 38, 0x0000000001010000002f6b62812faa51c0c7551b52fbba40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(38, 39, 0x000000000101000000252b757f2baa51c0c13a8e1f2abc40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(39, 40, 0x000000000101000000f9e41714bca951c055f65d11fcbc40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(40, 41, 0x000000000101000000b4d43032b7a951c004aa7f10c9bd40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(41, 42, 0x00000000010100000024230ca8dca951c02263ff869abe40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(42, 43, 0x000000000101000000c97eccbdf6a951c0ecf65965a6bf40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(43, 44, 0x000000000101000000697c15cf0faa51c0b9944e7f51c040c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(44, 45, 0x0000000001010000003a8375d231aa51c092109b7e3fc140c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(45, 46, 0x000000000101000000acb5e67d52aa51c0b6114f7633c240c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(46, 47, 0x000000000101000000f8ce1e1e78aa51c01019a07e61c340c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(47, 48, 0x000000000101000000fa15212baeaa51c00b3fdde5c7c440c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(48, 49, 0x000000000101000000098442a9e2ae51c0d13e56f0dbae40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(49, 50, 0x0000000001010000001f25c0fa09b051c00d2f2d8fdaae40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(50, 51, 0x0000000001010000001f25c0fa09b051c003e9071ad8ae40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(51, 52, 0x000000000101000000ba2583ed71ac51c0439259bdc3ae40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(52, 53, 0x00000000010100000019f89b9a15ac51c0822dc088c7af40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(53, 54, 0x00000000010100000089f83da0a2ab51c07ff6234564b140c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(54, 55, 0x000000000101000000f2423a3c04ab51c05ae322ade7b240c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(55, 56, 0x000000000101000000f8414c7878aa51c036aca92c0ab440c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(56, 57, 0x0000000001010000002511d0332caa51c0be326fd575b540c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(57, 58, 0x0000000001010000003a90f5d4eaa951c09780a9b063b740c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(58, 59, 0x0000000001010000006ad729fbd3a951c09bb0581effb740c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(59, 60, 0x0000000001010000000b84f81bc8a951c09a8933d0c6b840c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(60, 61, 0x0000000001010000002585c31ccea951c0a46dfc89cab940c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(61, 62, 0x000000000101000000b9dfa12850a951c09126de019eba40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(62, 63, 0x00000000010100000023f202916aa851c0fa28232e00ba40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(63, 64, 0x0000000001010000000c32135674a751c09e279eb305ba40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(64, 65, 0x0000000001010000007cf8e8c3e9a651c09611cdf22bba40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(65, 66, 0x0000000001010000009cf28d8d65a651c045e91c4d3fba40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(66, 67, 0x00000000010100000044ec021459a551c0f96871c630ba40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(67, 68, 0x0000000001010000003d5c1723b7a451c0538bd2ef0cba40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(68, 69, 0x000000000101000000c9440026dfa351c01ea8531eddb940c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(69, 70, 0x000000000101000000782ae09ee7a351c0a8c4758c2bbe40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(70, 71, 0x0000000001010000003b43273a01a651c0b084ffbe90b640c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(71, 72, 0x000000000101000000f9591b199aa551c03e31a13836b740c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(72, 73, 0x00000000010100000021bd97b1d7a451c0e42d573f36b840c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(73, 74, 0x000000000101000000e9d32afac3a451c0777066aa16b940c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(74, 75, 0x000000000101000000bd080907b1a451c0fd497cee04ba40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(75, 76, 0x000000000101000000e5362becb3a451c0530e1c8645bb40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(76, 77, 0x00000000010100000079d6242e36a551c0cdc75ae8efbb40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(77, 78, 0x00000000010100000027ca94c533a551c04da25ef069bd40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(78, 79, 0x000000000101000000b3aca00e50a551c0e139a5cd82be40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(79, 80, 0x0000000001010000006ea46c91b4a551c0cd34ab88e4bf40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(80, 81, 0x000000000101000000cea21c71eda551c0c9c7ee0225c140c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(81, 82, 0x000000000101000000cb1c812e50a651c03a234a7b83c240c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(82, 83, 0x000000000101000000ddbefd6f5ba651c0352905dd5ec340c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(83, 84, 0x000000000101000000e2db059417a651c023ba675da3c440c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(84, 85, 0x0000000001010000005c4de83fb5a551c01e047866ddc640c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(85, 86, 0x000000000101000000cd4de5feb4a551c006f0bb8eddc640c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(86, 87, 0x000000000101000000498be9f89ea551c0047fae6cd5c740c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(87, 88, 0x000000000101000000c772011e87a551c0fe82386ae0c840c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(88, 89, 0x000000000101000000569a94826ea551c03f350301d7c940c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(89, 90, 0x00000000010100000041cea04646a551c08e1e64fe76cb40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(90, 91, 0x0000000001010000009dfc71561fa551c0f7f35c95facc40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(91, 92, 0x000000000101000000b6ae87e505a551c045f6419605ce40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(92, 93, 0x000000000101000000cc35bba4a0b051c0f04c689258c140c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(93, 94, 0x0000000001010000002ca688c29db051c0c94b48b599bf40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(94, 95, 0x0000000001010000008f07115f5cb051c05ef23ff9bbbe40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(95, 96, 0x000000000101000000997e8978ebaf51c060915f3fc4bd40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(96, 97, 0x000000000101000000267b3a0d87af51c04fae2990d9bc40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(97, 98, 0x000000000101000000505b7e3b64af51c0da2ca8b926bb40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(98, 99, 0x000000000101000000a05edf3d76af51c0b4c70be9f0b940c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(99, 100, 0x00000000010100000060d50fa095af51c0242fc61bf4b840c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(100, 101, 0x000000000101000000f069f3a471ae51c04cb0ee0edfb840c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(101, 102, 0x00000000010100000057f43dd903ae51c0637b2de8bdb840c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(102, 103, 0x000000000101000000b4e908e066ad51c023884e2a75b840c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(103, 104, 0x000000000101000000c883e3e860ac51c064e597c118b840c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(104, 105, 0x0000000001010000008ecc237fb0ab51c0276fdb5262b840c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(105, 106, 0x0000000001010000002b3d89bef1aa51c00f29064834b840c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(106, 107, 0x000000000101000000cdea1d6e87aa51c0c675429e13b840c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(107, 108, 0x0000000001010000006ad729fbd3a951c09bb0581effb740c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(108, 109, 0x00000000010100000020eb4e1c65a951c0befb3e77ddb740c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(109, 110, 0x000000000101000000d39453f1b5a851c073d87dc7f0b740c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(110, 111, 0x0000000001010000004215ede096a851c05904b5ceaeb840c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(111, 112, 0x000000000101000000bbdeecc586a851c0b341261939b940c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(112, 113, 0x0000000001010000003769bf5a5aa851c0dce1653c00ba40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(113, 114, 0x000000000101000000e9c4d44c2da851c02cd505bcccbb40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(114, 115, 0x0000000001010000008a48032efea751c061fbc9181fbd40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(115, 116, 0x00000000010100000063f19bc2caa751c0f66d77c542be40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(116, 117, 0x000000000101000000d6c33cd0afa751c02bf86d88f1be40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(117, 118, 0x000000000101000000724001ca95a751c0fa2d9512ddbf40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(118, 119, 0x0000000001010000009ff0c80e60a751c0ee940ed6ffc040c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(119, 120, 0x000000000101000000a13c3d00f3a651c004b23275b2c140c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(120, 121, 0x000000000101000000d184dcfb8aa651c0789ed38789c240c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(121, 122, 0x000000000101000000ddbefd6f5ba651c0352905dd5ec340c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(122, 123, 0x0000000001010000009f4ec3013eb051c00509409248c040c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(123, 124, 0x0000000001010000003b95c272baab51c0317daf2138bd40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(124, 125, 0x000000000101000000b5aff2bab4aa51c08f6e844545bd40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(125, 126, 0x000000000101000000f9e41714bca951c055f65d11fcbc40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(126, 127, 0x000000000101000000b85dc36746a951c0e443f57b07bd40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(127, 128, 0x000000000101000000e9c4d44c2da851c02cd505bcccbb40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(128, 129, 0x00000000010100000024fe17bef4a651c09c16bce82bbb40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(129, 130, 0x0000000001010000007cf8e8c3e9a651c09611cdf22bba40c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(130, 131, 0x0000000001010000003407527303a751c0e73cbe1825b840c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54'),
(131, 132, 0x000000000101000000b477a11408b640c05d7bb0d61aa751c0, '2024-03-27 09:41:54', '2024-03-27 12:41:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stations`
--

CREATE TABLE `stations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `stations`
--

INSERT INTO `stations` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'San Pablo', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(2, 'Neptuno', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(3, 'Pajaritos', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(4, 'Las Rejas', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(5, 'Ecuador', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(6, 'San Alberto Hurtado', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(7, 'Universidad de Santiago', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(8, 'Estación Central', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(9, 'Unión Latinoamericana', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(10, 'República', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(11, 'Los Héroes', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(12, 'La Moneda', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(13, 'Universidad de Chile', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(14, 'Santa Lucía', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(15, 'Universidad Católica', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(16, 'Baquedano', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(17, 'Salvador', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(18, 'Manuel Montt', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(19, 'Pedro de Valdivia', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(20, 'Los Leones', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(21, 'Tobalaba', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(22, 'El Golf', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(23, 'Alcántara', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(24, 'Escuela Militar', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(25, 'Manquehue', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(26, 'Hernando de Magallanes', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(27, 'Los Dominicos', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(28, 'Vespucio Norte', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(29, 'Zapadores', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(30, 'Dorsal', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(31, 'Einstein', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(32, 'Cementerios', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(33, 'Cerro Blanco', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(34, 'Patronato', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(35, 'Puente Cal y Canto', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(36, 'Santa Ana', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(37, 'Los Héroes', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(38, 'Toesca', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(39, 'Parque O\'Higgins', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(40, 'Rondizzoni', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(41, 'Franklin', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(42, 'El Llano', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(43, 'San Miguel', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(44, 'Lo Vial', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(45, 'Departamental', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(46, 'Ciudad del Niño', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(47, 'Lo Ovalle', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(48, 'El Parrón', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(49, 'La Cisterna', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(50, 'Plaza Quilicura', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(51, 'Lo Cruzat', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(52, 'Ferrocarril', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(53, 'Los Libertadores', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(54, 'Cardenal Caro', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(55, 'Vivaceta', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(56, 'Conchalí', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(57, 'Plaza Chacabuco', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(58, 'Hospitales', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(59, 'Puente Cal y Canto', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(60, 'Plaza de Armas', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(61, 'Universidad de Chile', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(62, 'Parque Almagro', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(63, 'Matta', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(64, 'Irarrázaval', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(65, 'Monseñor Eyzaguirre', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(66, 'Ñuñoa', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(67, 'Chile España', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(68, 'Villa Frei', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(69, 'Plaza Egaña', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(70, 'Fernando Castillo Velasco', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(71, 'Tobalaba', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(72, 'Cristóbal Colón', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(73, 'Francisco Bilbao', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(74, 'Príncipe de Gales', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(75, 'Simón Bolívar', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(76, 'Plaza Egaña', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(77, 'Los Orientales', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(78, 'Grecia', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(79, 'Los Presidentes', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(80, 'Quilín', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(81, 'Las Torres', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(82, 'Macul', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(83, 'Vicuña Mackenna', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(84, 'Vicente Valdés', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(85, 'Rojas Magallanes', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(86, 'Trinidad', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(87, 'San José de la Estrella', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(88, 'Los Quillayes', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(89, 'Elisa Correa', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(90, 'Hospital Sótero del Río', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(91, 'Protectora de la Infancia', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(92, 'Las Mercedes', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(93, 'Plaza de Puente Alto', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(94, 'Plaza de Maipú', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(95, 'Santiago Bueras', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(96, 'Del Sol', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(97, 'Monte Tabor', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(98, 'Las Parcelas', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(99, 'Laguna Sur', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(100, 'Barrancas', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(101, 'Pudahuel', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(102, 'San Pablo', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(103, 'Lo Prado', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(104, 'Blanqueado', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(105, 'Gruta de Lourdes', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(106, 'Quinta Normal', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(107, 'Cumming', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(108, 'Santa Ana', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(109, 'Plaza de Armas', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(110, 'Bellas Artes', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(111, 'Baquedano', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(112, 'Parque Bustamante', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(113, 'Santa Isabel', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(114, 'Irarrázaval', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(115, 'Ñuble', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(116, 'Rodrigo de Araya', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(117, 'Carlos Valdovinos', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(118, 'Camino Agrícola', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(119, 'San Joaquín', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(120, 'Pedrero', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(121, 'Mirador', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(122, 'Bellavista de La Florida', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(123, 'Vicente Valdés', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(124, 'Cerrillos', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(125, 'Lo Valledor', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(126, 'Pdte. Pedro Aguirre Cerda', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(127, 'Franklin', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(128, 'Bío Bío', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(129, 'Ñuble', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(130, 'Estadio Nacional', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(131, 'Ñuñoa', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(132, 'Inés de Suárez', '2024-03-27 09:30:03', '2024-03-27 12:30:03'),
(133, 'Los Leones', '2024-03-27 09:30:03', '2024-03-27 12:30:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trains`
--

CREATE TABLE `trains` (
  `serial_number` varchar(10) NOT NULL,
  `line_id` bigint(20) UNSIGNED NOT NULL,
  `type` tinyint(4) NOT NULL,
  `year` int(4) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `trains`
--

INSERT INTO `trains` (`serial_number`, `line_id`, `type`, `year`, `created_at`, `updated_at`) VALUES
('0JFxafE4q8', 1, 1, 1963, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('2e5v4FHs0T', 3, 2, 1984, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('5xPdsZ1x9L', 3, 2, 1948, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('7csbz2qteT', 1, 1, 1971, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('8PwCI0CC6n', 4, 1, 1990, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('9ilxeEwlnH', 4, 2, 1994, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('aWDpmlRsOG', 4, 2, 1998, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('ax5jrpNIWG', 4, 2, 1952, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('B83fPCVFbH', 1, 1, 1990, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('Bv1MN0DuUm', 2, 2, 1952, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('D9m2gBhBJw', 2, 1, 1969, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('EDUumFCvJl', 2, 1, 1967, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('ejN3a4CsDC', 3, 2, 1997, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('f49Bk0GzBi', 4, 2, 1967, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('Ge92a6hVX8', 3, 2, 1967, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('Huz9yGcao5', 2, 1, 1980, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('Hvhw9vxUaH', 3, 1, 1983, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('JO5UinVh7B', 2, 1, 1956, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('MPbPGQfWxT', 2, 2, 1982, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('mS0SY0eScA', 3, 2, 1986, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('oCut3fDYXE', 3, 2, 1987, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('oRyT0nwjUn', 2, 1, 1988, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('OtmhQxSRpS', 3, 2, 1956, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('Pazz9JGCbJ', 1, 2, 1988, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('pBnf2N5Ncc', 4, 1, 1981, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('pMldxCQ2sS', 3, 1, 1984, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('q92m0d8aWM', 1, 1, 1979, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('QJ22USb3ry', 2, 1, 1949, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('rnpVQQPs5b', 4, 1, 1984, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('S06Q7kXYrP', 1, 1, 1990, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('s0QypBy7cJ', 2, 2, 1958, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('S6R4dX4THI', 2, 2, 1994, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('t8HhPpvYbU', 1, 2, 1996, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('U9xuOQl3kh', 3, 1, 1982, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('uibQ7F5VE7', 4, 1, 1961, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('Uj5G2Bodtk', 4, 2, 1985, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('VjPElNnH29', 3, 2, 1964, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('vOv1sCgHoa', 1, 1, 1947, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('VViBQInzq3', 4, 2, 1959, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('wGweNe36QH', 1, 2, 1987, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('Wh09mwE4yn', 4, 1, 1968, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('XE89MYo0IU', 3, 1, 1986, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('Z5qAgGpFTj', 1, 1, 1971, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('ZbX2yY5Wyz', 1, 2, 1966, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('zeaEgOCuYl', 2, 2, 1997, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('ZHA4kQokXG', 2, 1, 1977, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('zpO3I3tS4e', 1, 2, 1995, '2024-03-27 09:29:41', '2024-03-27 12:29:41'),
('zpYnPq7vmN', 4, 2, 1976, '2024-03-27 09:29:41', '2024-03-27 12:29:41');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `active_drivers`
--
ALTER TABLE `active_drivers`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `drivers`
--
ALTER TABLE `drivers`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `lines`
--
ALTER TABLE `lines`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `lines_stations`
--
ALTER TABLE `lines_stations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_lines_stations_line_id` (`line_id`),
  ADD KEY `fk_lines_stations_station_id` (`station_id`);

--
-- Indices de la tabla `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `locations_station_id_foreign` (`station_id`);

--
-- Indices de la tabla `stations`
--
ALTER TABLE `stations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `trains`
--
ALTER TABLE `trains`
  ADD PRIMARY KEY (`serial_number`),
  ADD KEY `trains_line_id_foreign` (`line_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `active_drivers`
--
ALTER TABLE `active_drivers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `drivers`
--
ALTER TABLE `drivers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `lines`
--
ALTER TABLE `lines`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `lines_stations`
--
ALTER TABLE `lines_stations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT de la tabla `stations`
--
ALTER TABLE `stations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `lines_stations`
--
ALTER TABLE `lines_stations`
  ADD CONSTRAINT `fk_lines_stations_line_id` FOREIGN KEY (`line_id`) REFERENCES `lines` (`id`),
  ADD CONSTRAINT `fk_lines_stations_station_id` FOREIGN KEY (`station_id`) REFERENCES `stations` (`id`);

--
-- Filtros para la tabla `locations`
--
ALTER TABLE `locations`
  ADD CONSTRAINT `locations_station_id_foreign` FOREIGN KEY (`station_id`) REFERENCES `stations` (`id`);

--
-- Filtros para la tabla `trains`
--
ALTER TABLE `trains`
  ADD CONSTRAINT `trains_line_id_foreign` FOREIGN KEY (`line_id`) REFERENCES `lines` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
