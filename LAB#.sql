USE master;
GO
DROP DATABASE IF EXISTS Beer_Party;
GO
CREATE DATABASE Beer_Party;
GO
USE Beer_Party;
GO

CREATE TABLE Students (
   StudentID INT PRIMARY KEY,
   StudentName VARCHAR(50),
   StudentAge INT
) AS NODE;

CREATE TABLE BeerBrands (
   BeerBrandID INT PRIMARY KEY,
   BeerBrandName VARCHAR(50),
   AlcoholContent FLOAT
) AS NODE;

CREATE TABLE Pubs (
   PubID INT PRIMARY KEY,
   PubName VARCHAR(50),
   PubLocation VARCHAR(50)
) AS NODE;

CREATE TABLE Friendships AS EDGE;
CREATE TABLE Visits (VisitDate DATE) AS EDGE;
CREATE TABLE BeerPreference AS EDGE;
CREATE TABLE PubOffersBeer (Amount FLOAT) AS EDGE;

INSERT INTO Students (StudentID, StudentName, StudentAge)
VALUES (1, 'Иванов Иван', 20),
       (2, 'Петров Петр', 21),
       (3, 'Сидоров Сидор', 19),
       (4, 'Кузнецова Анна', 22),
       (5, 'Баранова Елена', 18),
       (6, 'Александрова Александра', 23),
       (7, 'Краснова Наталья', 20),
       (8, 'Михайлова Ирина', 21),
       (9, 'Федорова Ольга', 19),
       (10, 'Григорьева Анастасия', 22);


INSERT INTO BeerBrands (BeerBrandID, BeerBrandName, AlcoholContent)
VALUES (1, 'Heineken', 5),
       (2, 'Budweiser', 5.5),
       (3, 'Guinness', 4.2),
       (4, 'Corona', 4.6),
       (5, 'Stella Artois', 5.2),
       (6, 'Beck’s', 5),
       (7, 'Hoegaarden', 4.9),
       (8, 'Leffe', 6.6),
       (9, 'Chimay', 8),
       (10, 'Duvel', 8.5);

INSERT INTO Pubs (PubID, PubName, PubLocation)
VALUES (1, 'The Irish Pub', 'Москва, ул. Ирландская, 10'),
       (2, 'The Beer Factory', 'Санкт-Петербург, пр. Пивной, 20'),
       (3, 'The Brewmaster', 'Казань, ул. Пивоварная, 5'),
       (4, 'The Hoppy Monk', 'Екатеринбург, ул. Монастырская, 12'),
       (5, 'The Beer Hunter', 'Ростов-на-Дону, пр. Охотничий, 15'),
       (6, 'The Drunken Clam', 'Новосибирск, ул. Бухгалтерская, 7'),
       (7, 'The Beer Cellar', 'Краснодар, ул. Пограничная, 2'),
       (8, 'The Beer House', 'Сочи, ул. Пивная, 30'),
       (9, 'The Taphouse', 'Владивосток, ул. Распродажная, 3'),
       (10, 'The Pub with No Name', 'Хабаровск, ул. Безымянная, 8');


INSERT INTO Friendships
VALUES ((SELECT $node_id FROM Students WHERE StudentID = 1), (SELECT $node_id FROM Students WHERE StudentID = 2))
		 , ((SELECT $node_id FROM Students WHERE StudentID = 1), (SELECT $node_id FROM Students WHERE StudentID = 3))
		 , ((SELECT $node_id FROM Students WHERE StudentID = 2), (SELECT $node_id FROM Students WHERE StudentID = 4))
		 , ((SELECT $node_id FROM Students WHERE StudentID = 2), (SELECT $node_id FROM Students WHERE StudentID = 3))
		 , ((SELECT $node_id FROM Students WHERE StudentID = 4), (SELECT $node_id FROM Students WHERE StudentID = 5))
		 , ((SELECT $node_id FROM Students WHERE StudentID = 7), (SELECT $node_id FROM Students WHERE StudentID = 8));

INSERT INTO Visits
VALUES ((SELECT $node_id FROM Students WHERE StudentID = 1), (SELECT $node_id FROM Pubs WHERE PubID = 4), '2022-09-09')
		, ((SELECT $node_id FROM Students WHERE StudentID = 2), (SELECT $node_id FROM Pubs WHERE PubID = 4), '2022-09-09')
		, ((SELECT $node_id FROM Students WHERE StudentID = 6), (SELECT $node_id FROM Pubs WHERE PubID = 1), '2022-10-23')
		, ((SELECT $node_id FROM Students WHERE StudentID = 7), (SELECT $node_id FROM Pubs WHERE PubID = 5), '2022-10-24')
		, ((SELECT $node_id FROM Students WHERE StudentID = 8), (SELECT $node_id FROM Pubs WHERE PubID = 5), '2022-10-24')
		, ((SELECT $node_id FROM Students WHERE StudentID = 4), (SELECT $node_id FROM Pubs WHERE PubID = 8), '2022-11-06')
		, ((SELECT $node_id FROM Students WHERE StudentID = 3), (SELECT $node_id FROM Pubs WHERE PubID = 2), '2022-11-06')
		, ((SELECT $node_id FROM Students WHERE StudentID = 5), (SELECT $node_id FROM Pubs WHERE PubID = 8), '2022-11-06');


INSERT INTO BeerPreference
VALUES ((SELECT $node_id FROM Students WHERE StudentID = 1), (SELECT $node_id FROM BeerBrands WHERE BeerBrandID = 1))
		, ((SELECT $node_id FROM Students WHERE StudentID = 2), (SELECT $node_id FROM BeerBrands WHERE BeerBrandID = 1))
		, ((SELECT $node_id FROM Students WHERE StudentID = 3), (SELECT $node_id FROM BeerBrands WHERE BeerBrandID = 2))
		, ((SELECT $node_id FROM Students WHERE StudentID = 4), (SELECT $node_id FROM BeerBrands WHERE BeerBrandID = 4))
		, ((SELECT $node_id FROM Students WHERE StudentID = 5), (SELECT $node_id FROM BeerBrands WHERE BeerBrandID = 5))
		, ((SELECT $node_id FROM Students WHERE StudentID = 7), (SELECT $node_id FROM BeerBrands WHERE BeerBrandID = 5))
		, ((SELECT $node_id FROM Students WHERE StudentID = 8), (SELECT $node_id FROM BeerBrands WHERE BeerBrandID = 6))
		, ((SELECT $node_id FROM Students WHERE StudentID = 9), (SELECT $node_id FROM BeerBrands WHERE BeerBrandID = 7));


INSERT INTO PubOffersBeer
VALUES ((SELECT $node_id FROM Pubs WHERE PubID = 5), (SELECT $node_id FROM BeerBrands WHERE BeerBrandID = 5), 100.00)
		, ((SELECT $node_id FROM Pubs WHERE PubID = 5), (SELECT $node_id FROM BeerBrands WHERE BeerBrandID = 6), 120.00)
		, ((SELECT $node_id FROM Pubs WHERE PubID = 1), (SELECT $node_id FROM BeerBrands WHERE BeerBrandID = 1), 105.50)
		, ((SELECT $node_id FROM Pubs WHERE PubID = 4), (SELECT $node_id FROM BeerBrands WHERE BeerBrandID = 1), 40.50)
		, ((SELECT $node_id FROM Pubs WHERE PubID = 5), (SELECT $node_id FROM BeerBrands WHERE BeerBrandID = 5), 93.00)
		, ((SELECT $node_id FROM Pubs WHERE PubID = 5), (SELECT $node_id FROM BeerBrands WHERE BeerBrandID = 4), 206.50)
		, ((SELECT $node_id FROM Pubs WHERE PubID = 2), (SELECT $node_id FROM BeerBrands WHERE BeerBrandID = 2), 20.50);

-- Find all the students who visited the bar that serves Stella Artois beer
SELECT DISTINCT Student.StudentName, Pub.PubName
FROM Students AS Student
 , PubOffersBeer
 , Visits
 , BeerBrands AS BeerBrand
 , Pubs AS Pub
WHERE MATCH(Student-(Visits)->Pub)
 AND MATCH(Pub-(PubOffersBeer)->BeerBrand)
 AND BeerBrand.BeerBrandName = 'Stella Artois';

 -- Find all the students who did not drink beer with an alcohol content higher than 6% but attended a pub in St. Petersburg
SELECT DISTINCT Student.StudentName
FROM  Students AS Student
 , PubOffersBeer
 , Visits
 , BeerBrands AS BeerBrand
 , Pubs AS Pub
WHERE MATCH (Student-(Visits)->Pub)
AND MATCH (Pub-(PubOffersBeer)->BeerBrand)
AND Pub.PubLocation = 'Санкт-Петербург, пр. Пивной, 20' AND NOT BeerBrand.AlcoholContent > 6

-- Find all the people who are not friends with anyone themselves
SELECT DISTINCT Student1.StudentName
FROM Students AS Student1
LEFT JOIN (
    SELECT DISTINCT Student1.StudentName 
    FROM Students AS Student1
        , Friendships
        , Students AS Student2
    WHERE MATCH (Student1-(Friendships)->Student2)
) AS StudentName
ON StudentName.StudentName = Student1.StudentName
WHERE StudentName.StudentName IS NULL

-- Find all the students who visited the bars
SELECT DISTINCT Student.StudentName 
FROM Students AS Student
	, Pubs AS Pub1
	, Pubs AS Pub2
	, Visits
WHERE MATCH (Student-(Visits)->Pub1)

-- Take out all the students who like beer Heineken
SELECT DISTINCT Student.StudentName
FROM Students AS Student
	, BeerPreference
	, BeerBrands AS BeerBrand
WHERE MATCH (Student-(BeerPreference)->BeerBrand)
AND BeerBrand.BeerBrandName = 'Heineken';

-- Select recursively friends and friends and friends of the student who attended the specified bars
SELECT
	Student1.StudentName,
	STRING_AGG(Student2.StudentName, '->') WITHIN GROUP (GRAPH PATH) AS Friends,
	Pub.PubName
FROM
	Students AS Student1,
	Friendships FOR PATH AS FS,
	Students FOR PATH  AS Student2,
	Visits,
	Pubs AS Pub
WHERE MATCH(SHORTEST_PATH(Student1(-(FS)->Student2){1,3}) AND LAST_NODE(Student2)-(Visits)->Pub)
AND Student1.StudentName = 'Иванов Иван'
AND (Pub.PubName = 'The Hoppy Monk' OR Pub.PubName = 'The Beer House')

-- Select recursively friends and friends and friends of the student
SELECT
	Student1.StudentName,
	STRING_AGG(Student2.StudentName, '->') WITHIN GROUP (GRAPH PATH) AS Friends
FROM
	Students AS Student1,
	Friendships FOR PATH AS FS,
	Students FOR PATH  AS Student2
WHERE MATCH(SHORTEST_PATH(Student1(-(FS)->Student2)+))
AND Student1.StudentName = 'Иванов Иван'
