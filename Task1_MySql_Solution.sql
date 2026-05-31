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