-- Create new table with only the columns you want to keep
CREATE TABLE games_new AS 
SELECT gameID, leagueID, season, date, homeTeamID, awayTeamID, homeGoals, awayGoals, homeProbability, drawProbability, awayProbability, homeGoalsHalfTime, awayGoalsHalfTime 
FROM games;

-- Drop the old table
DROP TABLE games;

-- Rename the new table
ALTER TABLE games_new RENAME TO games;