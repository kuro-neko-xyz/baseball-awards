-- Heaviest Hitters

WITH averageBatterWeight(teamName, year, avgWeight) AS (SELECT teams.name,
  batting.yearID,
  AVG(people.weight)
FROM batting
JOIN people
  ON batting.playerID = people.playerID
JOIN teams
  ON batting.teamID = teams.teamID
GROUP BY 1, 2)

SELECT DISTINCT ON (year) *
FROM averageBatterWeight
ORDER BY year, avgWeight DESC;

-- Shortest Sluggers

WITH averageBatterHeight(teamName, year, avgHeight) AS (SELECT teams.name,
  batting.yearID,
  AVG(people.height)
FROM batting
JOIN people
  ON batting.playerID = people.playerID
JOIN teams
  ON batting.teamID = teams.teamID
GROUP BY 1, 2)

SELECT DISTINCT ON (year) *
FROM averageBatterHeight
ORDER BY year, avgHeight;

-- Biggest Spenders

WITH totalSalaries(teamName, year, totalSalary) AS (SELECT teams.name,
  salaries.yearID,
  SUM(salaries.salary)
FROM salaries
JOIN teams
  ON salaries.teamID = teams.teamID
GROUP BY 1, 2)

SELECT DISTINCT ON (year) *
FROM totalSalaries
ORDER BY year, totalSalary DESC;

-- Most Bang For Their Buck In 2010

WITH totalSalaries(teamID, teamName, year, totalSalary) AS (SELECT teams.teamID,
  teams.name,
  salaries.yearID,
  SUM(salaries.salary)
FROM salaries
JOIN teams
  ON salaries.teamID = teams.teamID
GROUP BY 1, 2, 3)

SELECT DISTINCT ON (totalSalaries.year) totalSalaries.teamName,
  totalSalaries.year,
  totalSalaries.totalSalary,
  teams.W,
  ROUND(totalSalaries.totalSalary / teams.W)
FROM totalSalaries
JOIN teams
  ON totalSalaries.teamID = teams.teamID
  AND totalSalaries.year = teams.yearID
ORDER BY 2, 5;

-- Priciest Starter

WITH pitchersSalaryPerYear AS (SELECT people.playerID,
  people.nameGiven,
  people.nameLast,
  salaries.salary,
  pitching.yearID,
  pitching.teamID,
  pitching.GS,
  ROUND(salaries.salary / pitching.GS)
FROM pitching
JOIN salaries
  ON pitching.playerID = salaries.playerID
  AND pitching.yearId = salaries.yearID
  AND pitching.teamID = salaries.teamID
JOIN people
  ON pitching.playerID = people.playerID
WHERE pitching.GS > 0)

SELECT DISTINCT ON (yearID) *
FROM pitchersSalaryPerYear
ORDER BY 5, 8 DESC;

-- Tallest Sluggers

WITH averageBatterHeight(teamName, year, avgHeight) AS (SELECT teams.name,
  batting.yearID,
  AVG(people.height)
FROM batting
JOIN people
  ON batting.playerID = people.playerID
JOIN teams
  ON batting.teamID = teams.teamID
GROUP BY 1, 2)

SELECT DISTINCT ON (year) *
FROM averageBatterHeight
ORDER BY year, avgHeight DESC;