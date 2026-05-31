-- DB 1
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP DATABASE IF EXISTS `nes_db_1`;
CREATE DATABASE IF NOT EXISTS `nes_db_1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `nes_db_1`;

DROP TABLE IF EXISTS `bicycle`;
CREATE TABLE IF NOT EXISTS `bicycle` (
  `serial_number` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `gear_count` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `type` enum('Mountain','Road','Hybrid') COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`serial_number`),
  KEY `model` (`model`),
  CONSTRAINT `bicycle_ibfk_1` FOREIGN KEY (`model`) REFERENCES `vehicle` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `bicycle` (`serial_number`, `model`, `gear_count`, `price`, `type`) VALUES
	('SN123456789', 'Domane', 22, 3500.00, 'Road'),
	('SN456789123', 'Stumpjumper', 30, 4000.00, 'Mountain'),
	('SN987654321', 'Defy', 20, 3000.00, 'Road');

DROP TABLE IF EXISTS `car`;
CREATE TABLE IF NOT EXISTS `car` (
  `vin` varchar(17) COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `engine_capacity` decimal(4,2) NOT NULL,
  `horsepower` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `transmission` enum('Automatic','Manual') COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`vin`),
  KEY `model` (`model`),
  CONSTRAINT `car_ibfk_1` FOREIGN KEY (`model`) REFERENCES `vehicle` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `car` (`vin`, `model`, `engine_capacity`, `horsepower`, `price`, `transmission`) VALUES
	('1FA6P8CF0J1234567', 'Mustang', 5.00, 450, 55000.00, 'Automatic'),
	('1HGCM82633A123456', 'Camry', 2.50, 203, 24000.00, 'Automatic'),
	('2HGFG3B53GH123456', 'Civic', 2.00, 158, 22000.00, 'Manual');

DROP TABLE IF EXISTS `motorcycle`;
CREATE TABLE IF NOT EXISTS `motorcycle` (
  `vin` varchar(17) COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `engine_capacity` decimal(4,2) NOT NULL,
  `horsepower` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `type` enum('Sport','Cruiser','Touring') COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`vin`),
  KEY `model` (`model`),
  CONSTRAINT `motorcycle_ibfk_1` FOREIGN KEY (`model`) REFERENCES `vehicle` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `motorcycle` (`vin`, `model`, `engine_capacity`, `horsepower`, `price`, `type`) VALUES
	('1HD1ZK3158K123456', 'Sportster', 1.20, 70, 12000.00, 'Cruiser'),
	('JKBVNAF156A123456', 'Ninja', 0.90, 150, 14000.00, 'Sport'),
	('JYARN28E9FA123456', 'YZF-R1', 1.00, 200, 17000.00, 'Sport');

DROP TABLE IF EXISTS `vehicle`;
CREATE TABLE IF NOT EXISTS `vehicle` (
  `maker` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `type` enum('Car','Motorcycle','Bicycle') COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `vehicle` (`maker`, `model`, `type`) VALUES
	('Toyota', 'Camry', 'Car'),
	('Honda', 'Civic', 'Car'),
	('Giant', 'Defy', 'Bicycle'),
	('Trek', 'Domane', 'Bicycle'),
	('Ford', 'Mustang', 'Car'),
	('Kawasaki', 'Ninja', 'Motorcycle'),
	('Harley-Davidson', 'Sportster', 'Motorcycle'),
	('Specialized', 'Stumpjumper', 'Bicycle'),
	('Yamaha', 'YZF-R1', 'Motorcycle');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

-- Task 1
SELECT 
    v.maker,
    m.model
FROM 
    motorcycle m
    JOIN vehicle v ON m.model = v.model
WHERE 
    m.horsepower > 150
    AND m.price < 20000
    AND m.type = 'Sport'
ORDER BY 
    m.horsepower DESC;
    
    
-- Task 2
SELECT 
    v.maker,
    v.model,
    c.horsepower,
    c.engine_capacity,
    'Car' AS vehicle_type
FROM 
    vehicle v
JOIN 
    car c ON v.model = c.model
WHERE 
    c.horsepower > 150 
    AND c.engine_capacity < 3.0 
    AND c.price < 35000.00

UNION ALL

SELECT 
    v.maker,
    v.model,
    m.horsepower,
    m.engine_capacity,
    'Motorcycle' AS vehicle_type
FROM 
    vehicle v
JOIN 
    motorcycle m ON v.model = m.model
WHERE 
    m.horsepower > 150 
    AND m.engine_capacity < 1.5 
    AND m.price < 20000.00

UNION ALL

SELECT 
    v.maker,
    v.model,
    NULL AS horsepower,
    NULL AS engine_capacity,
    'Bicycle' AS vehicle_type
FROM 
    vehicle v
JOIN 
    bicycle b ON v.model = b.model
WHERE 
    b.gear_count > 18 
    AND b.price < 4000.00

ORDER BY 
    horsepower DESC;



-- DB 2
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



-- DB 3
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP DATABASE IF EXISTS `nes_db_3`;
CREATE DATABASE IF NOT EXISTS `nes_db_3` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `nes_db_3`;


CREATE TABLE IF NOT EXISTS `booking` (
  `ID_booking` int NOT NULL,
  `ID_room` int DEFAULT NULL,
  `ID_customer` int DEFAULT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  PRIMARY KEY (`ID_booking`),
  KEY `ID_room` (`ID_room`),
  KEY `ID_customer` (`ID_customer`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`ID_room`) REFERENCES `room` (`ID_room`),
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`ID_customer`) REFERENCES `customer` (`ID_customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `booking` (`ID_booking`, `ID_room`, `ID_customer`, `check_in_date`, `check_out_date`) VALUES
	(1, 1, 1, '2025-05-01', '2025-05-05'),
	(2, 2, 2, '2025-05-02', '2025-05-06'),
	(3, 3, 3, '2025-05-03', '2025-05-07'),
	(4, 4, 4, '2025-05-04', '2025-05-08'),
	(5, 5, 5, '2025-05-05', '2025-05-09'),
	(6, 6, 6, '2025-05-06', '2025-05-10'),
	(7, 7, 7, '2025-05-07', '2025-05-11'),
	(8, 8, 8, '2025-05-08', '2025-05-12'),
	(9, 9, 9, '2025-05-09', '2025-05-13'),
	(10, 10, 10, '2025-05-10', '2025-05-14'),
	(11, 1, 2, '2025-05-11', '2025-05-15'),
	(12, 2, 3, '2025-05-12', '2025-05-14'),
	(13, 3, 4, '2025-05-13', '2025-05-15'),
	(14, 4, 5, '2025-05-14', '2025-05-16'),
	(15, 5, 6, '2025-05-15', '2025-05-16'),
	(16, 6, 7, '2025-05-16', '2025-05-18'),
	(17, 7, 8, '2025-05-17', '2025-05-21'),
	(18, 8, 9, '2025-05-18', '2025-05-19'),
	(19, 9, 10, '2025-05-19', '2025-05-22'),
	(20, 10, 1, '2025-05-20', '2025-05-22'),
	(21, 1, 2, '2025-05-21', '2025-05-23'),
	(22, 2, 3, '2025-05-22', '2025-05-25'),
	(23, 3, 4, '2025-05-23', '2025-05-26'),
	(24, 4, 5, '2025-05-24', '2025-05-25'),
	(25, 5, 6, '2025-05-25', '2025-05-27'),
	(26, 6, 7, '2025-05-26', '2025-05-29');

CREATE TABLE IF NOT EXISTS `customer` (
  `ID_customer` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID_customer`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `customer` (`ID_customer`, `name`, `email`, `phone`) VALUES
	(1, 'John Doe', 'john.doe@example.com', '+1234567890'),
	(2, 'Jane Smith', 'jane.smith@example.com', '+0987654321'),
	(3, 'Alice Johnson', 'alice.johnson@example.com', '+1122334455'),
	(4, 'Bob Brown', 'bob.brown@example.com', '+2233445566'),
	(5, 'Charlie White', 'charlie.white@example.com', '+3344556677'),
	(6, 'Diana Prince', 'diana.prince@example.com', '+4455667788'),
	(7, 'Ethan Hunt', 'ethan.hunt@example.com', '+5566778899'),
	(8, 'Fiona Apple', 'fiona.apple@example.com', '+6677889900'),
	(9, 'George Washington', 'george.washington@example.com', '+7788990011'),
	(10, 'Hannah Montana', 'hannah.montana@example.com', '+8899001122');

CREATE TABLE IF NOT EXISTS `hotel` (
  `ID_hotel` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `location` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID_hotel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `hotel` (`ID_hotel`, `name`, `location`) VALUES
	(1, 'Grand Hotel', 'Paris, France'),
	(2, 'Ocean View Resort', 'Miami, USA'),
	(3, 'Mountain Retreat', 'Aspen, USA'),
	(4, 'City Center Inn', 'New York, USA'),
	(5, 'Desert Oasis', 'Las Vegas, USA'),
	(6, 'Lakeside Lodge', 'Lake Tahoe, USA'),
	(7, 'Historic Castle', 'Edinburgh, Scotland'),
	(8, 'Tropical Paradise', 'Bali, Indonesia'),
	(9, 'Business Suites', 'Tokyo, Japan'),
	(10, 'Eco-Friendly Hotel', 'Copenhagen, Denmark');

CREATE TABLE IF NOT EXISTS `room` (
  `ID_room` int NOT NULL,
  `ID_hotel` int DEFAULT NULL,
  `room_type` enum('Single','Double','Suite') COLLATE utf8mb4_general_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `capacity` int NOT NULL,
  PRIMARY KEY (`ID_room`),
  KEY `ID_hotel` (`ID_hotel`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`ID_hotel`) REFERENCES `hotel` (`ID_hotel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `room` (`ID_room`, `ID_hotel`, `room_type`, `price`, `capacity`) VALUES
	(1, 1, 'Single', 150.00, 1),
	(2, 1, 'Double', 200.00, 2),
	(3, 1, 'Suite', 350.00, 4),
	(4, 2, 'Single', 120.00, 1),
	(5, 2, 'Double', 180.00, 2),
	(6, 2, 'Suite', 300.00, 4),
	(7, 3, 'Double', 250.00, 2),
	(8, 3, 'Suite', 400.00, 4),
	(9, 4, 'Single', 100.00, 1),
	(10, 4, 'Double', 150.00, 2),
	(11, 5, 'Single', 90.00, 1),
	(12, 5, 'Double', 140.00, 2),
	(13, 6, 'Suite', 280.00, 4),
	(14, 7, 'Double', 220.00, 2),
	(15, 8, 'Single', 130.00, 1),
	(16, 8, 'Double', 190.00, 2),
	(17, 9, 'Suite', 360.00, 4),
	(18, 10, 'Single', 110.00, 1),
	(19, 10, 'Double', 160.00, 2);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

-- Task 1
SELECT 
    c.name,
    c.email,
    c.phone,
    COUNT(b.ID_booking) AS total_bookings,
    GROUP_CONCAT(DISTINCT h.name ORDER BY h.name SEPARATOR ', ') AS hotels_list,
    AVG(DATEDIFF(b.check_out_date, b.check_in_date)) AS avg_stay_duration
FROM Customer c
JOIN Booking b ON c.ID_customer = b.ID_customer
JOIN Room r ON b.ID_room = r.ID_room
JOIN Hotel h ON r.ID_hotel = h.ID_hotel
GROUP BY c.ID_customer, c.name, c.email, c.phone
HAVING 
    COUNT(DISTINCT r.ID_hotel) > 1  -- бронирования в разных отелях
    AND COUNT(b.ID_booking) > 2      -- более двух бронирований
ORDER BY total_bookings DESC;

-- Task 2
WITH customer_stats AS (
    -- Базовые агрегаты по каждому клиенту
    SELECT 
        c.ID_customer,
        c.name,
        COUNT(b.ID_booking) AS total_bookings,
        SUM(r.price * DATEDIFF(b.check_out_date, b.check_in_date)) AS total_spent,
        COUNT(DISTINCT h.ID_hotel) AS unique_hotels
    FROM Customer c
    JOIN Booking b ON c.ID_customer = b.ID_customer
    JOIN Room r ON b.ID_room = r.ID_room
    JOIN Hotel h ON r.ID_hotel = h.ID_hotel
    GROUP BY c.ID_customer, c.name
),
-- Клиенты, которые сделали более двух бронирований в разных отелях
condition1 AS (
    SELECT 
        ID_customer,
        name,
        total_bookings,
        total_spent,
        unique_hotels
    FROM customer_stats
    WHERE total_bookings > 2 AND unique_hotels > 1
),
-- Клиенты, которые потратили более 500 долларов
condition2 AS (
    SELECT 
        ID_customer,
        name,
        total_bookings,
        total_spent,
        unique_hotels
    FROM customer_stats
    WHERE total_spent > 500
)
-- Объединяем клиентов, которые соответствуют обоим условиям
SELECT 
    ID_customer,
    name,
    total_bookings,
    total_spent,
    unique_hotels
FROM condition1
WHERE ID_customer IN (SELECT ID_customer FROM condition2)
ORDER BY total_spent ASC;

-- Task 3
WITH hotel_category AS (
    -- Определяем категорию каждого отеля на основе средней стоимости номера
    SELECT 
        h.ID_hotel,
        h.name AS hotel_name,
        AVG(r.price) AS avg_price,
        CASE 
            WHEN AVG(r.price) < 175 THEN 'Дешевый'
            WHEN AVG(r.price) BETWEEN 175 AND 300 THEN 'Средний'
            ELSE 'Дорогой'
        END AS hotel_category
    FROM Hotel h
    JOIN Room r ON h.ID_hotel = r.ID_hotel
    GROUP BY h.ID_hotel, h.name
),

customer_hotels AS (
    -- Получаем для каждого клиента все отели, которые он посетил
    SELECT DISTINCT
        c.ID_customer,
        c.name,
        hc.hotel_name,
        hc.hotel_category
    FROM Customer c
    JOIN Booking b ON c.ID_customer = b.ID_customer
    JOIN Room r ON b.ID_room = r.ID_room
    JOIN hotel_category hc ON r.ID_hotel = hc.ID_hotel
),

customer_preference AS (
    -- Определяем предпочитаемый тип отеля для каждого клиента
    SELECT 
        ID_customer,
        name,
        CASE 
            WHEN SUM(CASE WHEN hotel_category = 'Дорогой' THEN 1 ELSE 0 END) > 0 THEN 'Дорогой'
            WHEN SUM(CASE WHEN hotel_category = 'Средний' THEN 1 ELSE 0 END) > 0 THEN 'Средний'
            ELSE 'Дешевый'
        END AS preferred_hotel_type,
        GROUP_CONCAT(DISTINCT hotel_name ORDER BY hotel_name SEPARATOR ',') AS visited_hotels
    FROM customer_hotels
    GROUP BY ID_customer, name
)

-- Финальный вывод с сортировкой
SELECT 
    ID_customer,
    name,
    preferred_hotel_type,
    visited_hotels
FROM customer_preference
ORDER BY 
    CASE preferred_hotel_type
        WHEN 'Дешевый' THEN 1
        WHEN 'Средний' THEN 2
        WHEN 'Дорогой' THEN 3
    END;



-- DB 4
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP DATABASE IF EXISTS `nes_db_4`;
CREATE DATABASE IF NOT EXISTS `nes_db_4` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `nes_db_4`;

DROP TABLE IF EXISTS `departments`;
CREATE TABLE IF NOT EXISTS `departments` (
  `DepartmentID` int NOT NULL,
  `DepartmentName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`DepartmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `departments` (`DepartmentID`, `DepartmentName`) VALUES
	(1, 'Отдел продаж'),
	(2, 'Отдел маркетинга'),
	(3, 'IT-отдел'),
	(4, 'Отдел разработки'),
	(5, 'Отдел поддержки');

DROP TABLE IF EXISTS `employees`;
CREATE TABLE IF NOT EXISTS `employees` (
  `EmployeeID` int NOT NULL,
  `Name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `Position` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ManagerID` int DEFAULT NULL,
  `DepartmentID` int DEFAULT NULL,
  `RoleID` int DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`),
  KEY `ManagerID` (`ManagerID`),
  KEY `DepartmentID` (`DepartmentID`),
  KEY `RoleID` (`RoleID`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`ManagerID`) REFERENCES `employees` (`EmployeeID`),
  CONSTRAINT `employees_ibfk_2` FOREIGN KEY (`DepartmentID`) REFERENCES `departments` (`DepartmentID`),
  CONSTRAINT `employees_ibfk_3` FOREIGN KEY (`RoleID`) REFERENCES `roles` (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `employees` (`EmployeeID`, `Name`, `Position`, `ManagerID`, `DepartmentID`, `RoleID`) VALUES
	(1, 'Иван Иванов', 'Генеральный директор', NULL, 1, 3),
	(2, 'Петр Петров', 'Директор по продажам', 1, 1, 2),
	(3, 'Светлана Светлова', 'Директор по маркетингу', 1, 2, 2),
	(4, 'Алексей Алексеев', 'Менеджер по продажам', 2, 1, 1),
	(5, 'Мария Мариева', 'Менеджер по маркетингу', 3, 2, 1),
	(6, 'Андрей Андреев', 'Разработчик', 1, 4, 4),
	(7, 'Елена Еленова', 'Специалист по поддержке', 1, 5, 5),
	(8, 'Олег Олегов', 'Менеджер по продукту', 2, 1, 1),
	(9, 'Татьяна Татеева', 'Маркетолог', 3, 2, 6),
	(10, 'Николай Николаев', 'Разработчик', 6, 4, 4),
	(11, 'Ирина Иринина', 'Разработчик', 6, 4, 4),
	(12, 'Сергей Сергеев', 'Специалист по поддержке', 7, 5, 5),
	(13, 'Кристина Кристинина', 'Менеджер по продажам', 4, 1, 1),
	(14, 'Дмитрий Дмитриев', 'Маркетолог', 3, 2, 6),
	(15, 'Виктор Викторов', 'Менеджер по продажам', 4, 1, 1),
	(16, 'Анастасия Анастасиева', 'Специалист по поддержке', 7, 5, 5),
	(17, 'Максим Максимов', 'Разработчик', 6, 4, 4),
	(18, 'Людмила Людмилова', 'Специалист по маркетингу', 3, 2, 6),
	(19, 'Наталья Натальева', 'Менеджер по продажам', 4, 1, 1),
	(20, 'Александр Александров', 'Менеджер по маркетингу', 3, 2, 1),
	(21, 'Галина Галина', 'Специалист по поддержке', 7, 5, 5),
	(22, 'Павел Павлов', 'Разработчик', 6, 4, 4),
	(23, 'Марина Маринина', 'Специалист по маркетингу', 3, 2, 6),
	(24, 'Станислав Станиславов', 'Менеджер по продажам', 4, 1, 1),
	(25, 'Екатерина Екатеринина', 'Специалист по поддержке', 7, 5, 5),
	(26, 'Денис Денисов', 'Разработчик', 6, 4, 4),
	(27, 'Ольга Ольгина', 'Маркетолог', 3, 2, 6),
	(28, 'Игорь Игорев', 'Менеджер по продукту', 2, 1, 1),
	(29, 'Анастасия Анастасиевна', 'Специалист по поддержке', 7, 5, 5),
	(30, 'Валентин Валентинов', 'Разработчик', 6, 4, 4);

DROP TABLE IF EXISTS `projects`;
CREATE TABLE IF NOT EXISTS `projects` (
  `ProjectID` int NOT NULL,
  `ProjectName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `DepartmentID` int DEFAULT NULL,
  PRIMARY KEY (`ProjectID`),
  KEY `DepartmentID` (`DepartmentID`),
  CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `departments` (`DepartmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `projects` (`ProjectID`, `ProjectName`, `StartDate`, `EndDate`, `DepartmentID`) VALUES
	(1, 'Проект A', '2025-01-01', '2025-12-31', 1),
	(2, 'Проект B', '2025-02-01', '2025-11-30', 2),
	(3, 'Проект C', '2025-03-01', '2025-10-31', 4),
	(4, 'Проект D', '2025-04-01', '2025-09-30', 5),
	(5, 'Проект E', '2025-05-01', '2025-08-31', 3);

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `RoleID` int NOT NULL,
  `RoleName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `roles` (`RoleID`, `RoleName`) VALUES
	(1, 'Менеджер'),
	(2, 'Директор'),
	(3, 'Генеральный директор'),
	(4, 'Разработчик'),
	(5, 'Специалист по поддержке'),
	(6, 'Маркетолог');

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE IF NOT EXISTS `tasks` (
  `TaskID` int NOT NULL,
  `TaskName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `AssignedTo` int DEFAULT NULL,
  `ProjectID` int DEFAULT NULL,
  PRIMARY KEY (`TaskID`),
  KEY `AssignedTo` (`AssignedTo`),
  KEY `ProjectID` (`ProjectID`),
  CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`AssignedTo`) REFERENCES `employees` (`EmployeeID`),
  CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`ProjectID`) REFERENCES `projects` (`ProjectID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `tasks` (`TaskID`, `TaskName`, `AssignedTo`, `ProjectID`) VALUES
	(1, 'Задача 1: Подготовка отчета по продажам', 4, 1),
	(2, 'Задача 2: Анализ рынка', 9, 2),
	(3, 'Задача 3: Разработка нового функционала', 10, 3),
	(4, 'Задача 4: Поддержка клиентов', 12, 4),
	(5, 'Задача 5: Создание рекламной кампании', 5, 2),
	(6, 'Задача 6: Обновление документации', 6, 3),
	(7, 'Задача 7: Проведение тренинга для сотрудников', 8, 1),
	(8, 'Задача 8: Тестирование нового продукта', 11, 3),
	(9, 'Задача 9: Ответы на запросы клиентов', 12, 4),
	(10, 'Задача 10: Подготовка маркетинговых материалов', 9, 2),
	(11, 'Задача 11: Интеграция с новым API', 10, 3),
	(12, 'Задача 12: Настройка системы поддержки', 7, 5),
	(13, 'Задача 13: Проведение анализа конкурентов', 9, 2),
	(14, 'Задача 14: Создание презентации для клиентов', 4, 1),
	(15, 'Задача 15: Обновление сайта', 6, 3);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

-- Task1
WITH RECURSIVE EmployeeHierarchy AS (
    -- Базовый запрос: сам Иван Иванов
    SELECT 
        EmployeeID,
        Name,
        ManagerID,
        DepartmentID,
        RoleID
    FROM Employees
    WHERE EmployeeID = 1
    
    UNION ALL
    
    -- Рекурсивный запрос: подчинённые
    SELECT 
        e.EmployeeID,
        e.Name,
        e.ManagerID,
        e.DepartmentID,
        e.RoleID
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT 
    eh.EmployeeID,
    eh.Name AS EmployeeName,
    eh.ManagerID,
    d.DepartmentName,
    r.RoleName,
    COALESCE(
        (SELECT GROUP_CONCAT(p.ProjectName ORDER BY p.ProjectName SEPARATOR ', ')
         FROM Projects p
         INNER JOIN Tasks t ON t.ProjectID = p.ProjectID
         WHERE t.AssignedTo = eh.EmployeeID
         GROUP BY t.AssignedTo),
        NULL
    ) AS ProjectNames,
    COALESCE(
        (SELECT GROUP_CONCAT(t.TaskName ORDER BY t.TaskName SEPARATOR ', ')
         FROM Tasks t
         WHERE t.AssignedTo = eh.EmployeeID),
        NULL
    ) AS TaskNames
FROM EmployeeHierarchy eh
LEFT JOIN Departments d ON eh.DepartmentID = d.DepartmentID
LEFT JOIN Roles r ON eh.RoleID = r.RoleID
ORDER BY eh.Name;

-- Task2
WITH RECURSIVE EmployeeHierarchy AS (
    -- Базовый запрос: начинаем с Ивана Иванова (EmployeeID = 1)
    SELECT 
        EmployeeID,
        Name,
        ManagerID,
        DepartmentID,
        RoleID
    FROM Employees
    WHERE EmployeeID = 1
    
    UNION ALL
    
    -- Рекурсивный запрос: находим подчиненных
    SELECT 
        e.EmployeeID,
        e.Name,
        e.ManagerID,
        e.DepartmentID,
        e.RoleID
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
),
-- Агрегируем проекты для каждого сотрудника
EmployeeProjects AS (
    SELECT 
        e.EmployeeID,
        GROUP_CONCAT(DISTINCT p.ProjectName ORDER BY p.ProjectName SEPARATOR ', ') AS ProjectNames
    FROM Employees e
    LEFT JOIN Tasks t ON e.EmployeeID = t.AssignedTo
    LEFT JOIN Projects p ON t.ProjectID = p.ProjectID
    GROUP BY e.EmployeeID
),
-- Агрегируем задачи для каждого сотрудника
EmployeeTasks AS (
    SELECT 
        AssignedTo AS EmployeeID,
        GROUP_CONCAT(TaskName ORDER BY TaskName SEPARATOR ', ') AS TaskNames,
        COUNT(TaskID) AS TotalTasks
    FROM Tasks
    GROUP BY AssignedTo
),
-- Считаем количество непосредственных подчиненных для каждого сотрудника
SubordinateCount AS (
    SELECT 
        ManagerID,
        COUNT(EmployeeID) AS TotalSubordinates
    FROM Employees
    WHERE ManagerID IS NOT NULL
    GROUP BY ManagerID
)
-- Финальный SELECT
SELECT 
    eh.EmployeeID,
    eh.Name AS EmployeeName,
    eh.ManagerID,
    d.DepartmentName,
    r.RoleName,
    ep.ProjectNames,
    et.TaskNames,
    COALESCE(et.TotalTasks, 0) AS TotalTasks,
    COALESCE(sc.TotalSubordinates, 0) AS TotalSubordinates
FROM EmployeeHierarchy eh
LEFT JOIN Departments d ON eh.DepartmentID = d.DepartmentID
LEFT JOIN Roles r ON eh.RoleID = r.RoleID
LEFT JOIN EmployeeProjects ep ON eh.EmployeeID = ep.EmployeeID
LEFT JOIN EmployeeTasks et ON eh.EmployeeID = et.EmployeeID
LEFT JOIN SubordinateCount sc ON eh.EmployeeID = sc.ManagerID
ORDER BY eh.EmployeeID;

-- Task3
WITH RECURSIVE Subordinates AS (
    -- Базовый запрос: каждый сотрудник и его непосредственный менеджер
    SELECT 
        EmployeeID,
        ManagerID
    FROM Employees
    
    UNION ALL
    
    -- Рекурсивный запрос: ищем всех подчиненных подчиненных
    SELECT 
        e.EmployeeID,
        s.ManagerID
    FROM Employees e
    INNER JOIN Subordinates s ON e.ManagerID = s.EmployeeID
),
SubordinatesCount AS (
    -- Подсчитываем общее количество подчиненных для каждого менеджера
    SELECT 
        ManagerID,
        COUNT(DISTINCT EmployeeID) AS TotalSubordinates
    FROM Subordinates
    WHERE ManagerID IS NOT NULL
    GROUP BY ManagerID
),
ManagerEmployees AS (
    -- Находим всех сотрудников, которые являются менеджерами и имеют подчиненных
    SELECT DISTINCT
        e.EmployeeID,
        e.Name AS EmployeeName,
        e.ManagerID,
        d.DepartmentName,
        r.RoleName
    FROM Employees e
    INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
    INNER JOIN Roles r ON e.RoleID = r.RoleID
    WHERE r.RoleName = 'Менеджер'
        AND EXISTS (SELECT 1 FROM Employees sub WHERE sub.ManagerID = e.EmployeeID)
)
SELECT 
    me.EmployeeID,
    me.EmployeeName,
    me.ManagerID,
    me.DepartmentName,
    me.RoleName,
    GROUP_CONCAT(DISTINCT p.ProjectName ORDER BY p.ProjectName SEPARATOR ', ') AS ProjectNames,
    GROUP_CONCAT(DISTINCT t.TaskName ORDER BY t.TaskName SEPARATOR ', ') AS TaskNames,
    sc.TotalSubordinates
FROM ManagerEmployees me
LEFT JOIN Employees e ON e.EmployeeID = me.EmployeeID
LEFT JOIN Tasks t ON t.AssignedTo = e.EmployeeID
LEFT JOIN Projects p ON p.ProjectID = t.ProjectID
LEFT JOIN SubordinatesCount sc ON sc.ManagerID = me.EmployeeID
GROUP BY 
    me.EmployeeID,
    me.EmployeeName,
    me.ManagerID,
    me.DepartmentName,
    me.RoleName,
    sc.TotalSubordinates
HAVING TotalSubordinates > 0
ORDER BY me.EmployeeID;