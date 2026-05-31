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