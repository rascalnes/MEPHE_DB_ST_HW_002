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