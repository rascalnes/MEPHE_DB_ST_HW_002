/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP DATABASE IF EXISTS `nes_db_2`;
CREATE DATABASE IF NOT EXISTS `nes_db_2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `nes_db_2`;

DROP TABLE IF EXISTS `cars`;
CREATE TABLE IF NOT EXISTS `cars` (
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `class` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `year` int NOT NULL,
  PRIMARY KEY (`name`),
  KEY `class` (`class`),
  CONSTRAINT `cars_ibfk_1` FOREIGN KEY (`class`) REFERENCES `classes` (`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `cars` (`name`, `class`, `year`) VALUES
	('Audi A4', 'Sedan', 2018),
	('BMW 3 Series', 'Sedan', 2019),
	('Chevrolet Camaro', 'Coupe', 2021),
	('Ferrari 488', 'Convertible', 2019),
	('Ford F-150', 'Pickup', 2021),
	('Ford Mustang', 'SportsCar', 2020),
	('Mercedes-Benz S-Class', 'Luxury Sedan', 2022),
	('Nissan Rogue', 'SUV', 2020),
	('Renault Clio', 'Hatchback', 2020),
	('Toyota RAV4', 'SUV', 2021);

DROP TABLE IF EXISTS `classes`;
CREATE TABLE IF NOT EXISTS `classes` (
  `class` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `type` enum('Racing','Street') COLLATE utf8mb4_general_ci NOT NULL,
  `country` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `numDoors` int NOT NULL,
  `engineSize` decimal(3,1) NOT NULL,
  `weight` int NOT NULL,
  PRIMARY KEY (`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `classes` (`class`, `type`, `country`, `numDoors`, `engineSize`, `weight`) VALUES
	('Convertible', 'Racing', 'Italy', 2, 3.0, 1300),
	('Coupe', 'Street', 'USA', 2, 2.5, 1400),
	('Hatchback', 'Street', 'France', 5, 1.6, 1100),
	('Luxury Sedan', 'Street', 'Germany', 4, 3.0, 1600),
	('Pickup', 'Street', 'USA', 2, 2.8, 2000),
	('Sedan', 'Street', 'Germany', 4, 2.0, 1200),
	('SportsCar', 'Racing', 'USA', 2, 3.5, 1500),
	('SUV', 'Street', 'Japan', 4, 2.5, 1800);

DROP TABLE IF EXISTS `races`;
CREATE TABLE IF NOT EXISTS `races` (
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `races` (`name`, `date`) VALUES
	('Bathurst 1000', '2023-10-08'),
	('Daytona 500', '2023-02-19'),
	('Indy 500', '2023-05-28'),
	('Le Mans', '2023-06-10'),
	('Monaco Grand Prix', '2023-05-28'),
	('Nürburgring 24 Hours', '2023-06-17'),
	('Pikes Peak International Hill Climb', '2023-06-25'),
	('Spa 24 Hours', '2023-07-29');

DROP TABLE IF EXISTS `results`;
CREATE TABLE IF NOT EXISTS `results` (
  `car` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `race` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `position` int NOT NULL,
  PRIMARY KEY (`car`,`race`),
  KEY `race` (`race`),
  CONSTRAINT `results_ibfk_1` FOREIGN KEY (`car`) REFERENCES `cars` (`name`),
  CONSTRAINT `results_ibfk_2` FOREIGN KEY (`race`) REFERENCES `races` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `results` (`car`, `race`, `position`) VALUES
	('Audi A4', 'Nürburgring 24 Hours', 8),
	('BMW 3 Series', 'Le Mans', 3),
	('Chevrolet Camaro', 'Monaco Grand Prix', 4),
	('Ferrari 488', 'Le Mans', 1),
	('Ford F-150', 'Bathurst 1000', 6),
	('Ford Mustang', 'Indy 500', 1),
	('Mercedes-Benz S-Class', 'Spa 24 Hours', 2),
	('Nissan Rogue', 'Pikes Peak International Hill Climb', 3),
	('Renault Clio', 'Daytona 500', 5),
	('Toyota RAV4', 'Monaco Grand Prix', 2);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

-- Task 1
WITH CarStats AS (
    SELECT 
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count
    FROM Cars c
    JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
MinAvgPerClass AS (
    SELECT 
        car_class,
        MIN(average_position) AS min_avg_position
    FROM CarStats
    GROUP BY car_class
)
SELECT 
    cs.car_name,
    cs.car_class,
    ROUND(cs.average_position, 4) AS average_position,
    cs.race_count
FROM CarStats cs
JOIN MinAvgPerClass m ON cs.car_class = m.car_class 
    AND cs.average_position = m.min_avg_position
ORDER BY cs.average_position;

-- Task 2
WITH CarStats AS (
    -- Рассчитываем среднюю позицию, количество гонок для каждого автомобиля
    SELECT 
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count
    FROM Cars c
    JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
MinAverage AS (
    -- Находим минимальную среднюю позицию
    SELECT MIN(average_position) AS min_avg_position
    FROM CarStats
)
-- Выбираем автомобиль с минимальной средней позицией
SELECT 
    cs.car_name,
    cs.car_class,
    ROUND(cs.average_position, 4) AS average_position,
    cs.race_count,
    cl.country AS car_country
FROM CarStats cs
JOIN MinAverage ma ON cs.average_position = ma.min_avg_position
JOIN Classes cl ON cs.car_class = cl.class
ORDER BY cs.car_name
LIMIT 1;

-- Task 3
WITH ClassAvg AS (
    -- Вычисляем среднюю позицию для каждого класса
    SELECT 
        c.class,
        AVG(r.position) AS class_avg_position
    FROM Cars c
    JOIN Results r ON c.name = r.car
    GROUP BY c.class
),
MinClassAvg AS (
    -- Находим наименьшую среднюю позицию среди всех классов
    SELECT MIN(class_avg_position) AS min_avg_position
    FROM ClassAvg
),
TargetClasses AS (
    -- Выбираем классы с наименьшей средней позицией
    SELECT class
    FROM ClassAvg
    WHERE class_avg_position = (SELECT min_avg_position FROM MinClassAvg)
),
CarStats AS (
    -- Вычисляем статистику для каждого автомобиля
    SELECT 
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count,
        cl.country AS car_country
    FROM Cars c
    JOIN Results r ON c.name = r.car
    JOIN Classes cl ON c.class = cl.class
    WHERE c.class IN (SELECT class FROM TargetClasses)
    GROUP BY c.name, c.class, cl.country
),
TotalRacesByClass AS (
    -- Вычисляем общее количество гонок для автомобилей целевых классов
    SELECT 
        c.class,
        COUNT(DISTINCT r.race) AS total_races
    FROM Cars c
    JOIN Results r ON c.name = r.car
    WHERE c.class IN (SELECT class FROM TargetClasses)
    GROUP BY c.class
)
-- Финальный вывод
SELECT 
    cs.car_name,
    cs.car_class,
    ROUND(cs.average_position, 4) AS average_position,
    cs.race_count,
    cs.car_country,
    trc.total_races
FROM CarStats cs
JOIN TotalRacesByClass trc ON cs.car_class = trc.class
ORDER BY cs.average_position, cs.car_name;

-- Task 4
WITH CarAverages AS (
    -- Средняя позиция для каждого автомобиля и количество гонок
    SELECT 
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count
    FROM Cars c
    JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
ClassAverages AS (
    -- Средняя позиция по классу (только для классов с >=2 автомобилями)
    SELECT 
        c.class,
        AVG(r.position) AS class_avg_position,
        COUNT(DISTINCT c.name) AS car_count
    FROM Cars c
    JOIN Results r ON c.name = r.car
    GROUP BY c.class
    HAVING COUNT(DISTINCT c.name) >= 2
)
-- Выбор автомобилей с позицией лучше средней по классу
SELECT 
    ca.car_name,
    ca.car_class,
    ROUND(ca.average_position, 4) AS average_position,
    ca.race_count,
    cl.country AS car_country
FROM CarAverages ca
JOIN ClassAverages cla ON ca.car_class = cla.class
JOIN Classes cl ON ca.car_class = cl.class
WHERE ca.average_position < cla.class_avg_position
ORDER BY ca.car_class, ca.average_position;

-- Task 5
WITH car_stats AS (
    -- Средняя позиция и количество гонок для каждого автомобиля
    SELECT 
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count
    FROM Cars c
    JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
class_low_position_count AS (
    -- Количество автомобилей с низкой средней позицией (> 3.0) в каждом классе
    SELECT 
        car_class,
        COUNT(*) AS low_position_count
    FROM car_stats
    WHERE average_position > 3.0
    GROUP BY car_class
),
target_classes AS (
    -- Классы, у которых есть автомобили с низкой средней позицией
    SELECT car_class
    FROM class_low_position_count
),
class_total_races AS (
    -- Общее количество гонок для каждого класса
    SELECT 
        c.class,
        COUNT(DISTINCT r.race) AS total_races
    FROM Cars c
    JOIN Results r ON c.name = r.car
    GROUP BY c.class
)
SELECT 
    cs.car_name,
    cs.car_class,
    ROUND(cs.average_position, 4) AS average_position,
    cs.race_count,
    cl.country AS car_country,
    ctr.total_races,
    clpc.low_position_count
FROM car_stats cs
JOIN Classes cl ON cs.car_class = cl.class
JOIN class_total_races ctr ON cs.car_class = ctr.class
JOIN class_low_position_count clpc ON cs.car_class = clpc.car_class
WHERE cs.average_position > 3.0
ORDER BY clpc.low_position_count DESC, cs.car_name;