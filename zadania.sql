-- Zadanie 23
SELECT Name, CountryCode, Population, MIN(Population) OVER (PARTITION BY CountryCode) AS min_pop, MAX(Population) OVER (PARTITION BY CountryCode) AS max_pop, AVG(Population) OVER (PARTITION BY CountryCode) AS avg_pop FROM city;

-- Zadanie 1
SELECT * FROM city WHERE CountryCode = "POL";

-- Zadanie 2
SELECT * FROM country WHERE Population BETWEEN 10000000 AND 20000000;

-- Zadanie 3
SELECT * FROM country WHERE Name LIKE "P%";

-- Zadanie 4
SELECT * FROM city WHERE CountryCode IN (SELECT Code FROM country WHERE Continent = "Europe");

-- Zadanie 5
SELECT * FROM country WHERE EXISTS (SELECT * FROM city WHERE Population > 5000000 AND city.CountryCode = country.Code);

-- Zadanie 6
SELECT * FROM country WHERE Population > (SELECT MAX(Population) FROM country WHERE Continent = "Europe");

-- Zadanie 7
SELECT AVG(Population) FROM city WHERE CountryCode = "POL";

-- Zadanie 8
SELECT Name, Population, (SELECT AVG(Population) FROM city WHERE city.CountryCode = country.Code) AS avg_city_population 
FROM country;

-- Zadanie 9
SELECT Name, 
CASE WHEN Population > 100000000 THEN "Very High Population" 
WHEN Population BETWEEN 50000000 AND 100000000 THEN "High Population" 
ELSE "Low Population" END AS population_category 
FROM country;

-- Zadanie 10
SELECT Name, 
CASE Continent 
WHEN "Asia" THEN "Asian" 
WHEN "Europe" THEN "European" 
ELSE "Other" END AS continent_category 
FROM country;

-- Zadanie 11
CREATE TEMPORARY TABLE temp_cities_in_poland AS SELECT * FROM city WHERE CountryCode = "POL";

-- Zadanie 12
SELECT * FROM city WHERE Population = (SELECT MAX(Population) FROM city WHERE CountryCode = "POL");

-- Zadanie 13
SELECT CountryCode, COUNT(*) AS city_count FROM city GROUP BY CountryCode;

-- Zadanie 14
SELECT CountryCode, COUNT(*) AS city_count FROM city GROUP BY CountryCode HAVING COUNT(*) > 10;

-- Zadanie 15
INSERT INTO city (Name, CountryCode, Population) VALUES ("New City", "POL", 200000);

-- Zadanie 16
INSERT INTO city (Name, CountryCode, Population) SELECT "New City 1", CountryCode, Population FROM city WHERE CountryCode = "POL";

-- Zadanie 17
UPDATE city SET Population = Population * 1.1 WHERE Name = "Warsaw";

-- Zadanie 18
UPDATE city SET Population = (SELECT AVG(Population) FROM city WHERE CountryCode = city.CountryCode) WHERE Name = "Krakow";

-- Zadanie 19
DELETE FROM city WHERE Population < 1000;

-- Zadanie 20
DELETE FROM city WHERE CountryCode IS NULL;

-- Zadanie 21
CREATE TEMPORARY TABLE avg_population AS 
SELECT CountryCode, AVG(Population) AS avg_pop FROM city GROUP BY CountryCode;
SELECT * FROM avg_population;

-- Zadanie 22
SELECT Name, Population, 1 AS level FROM city WHERE Population > 1000000
UNION ALL
SELECT city.Name, city.Population, 2 AS level 
FROM city 
JOIN (SELECT Population FROM city WHERE Population > 1000000) AS big_cities 
ON city.Population < big_cities.Population;