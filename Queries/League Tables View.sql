-- SQLite
SELECT
    season,
    League,
    Team,
    SUM(goals_scored) AS total_goals_scored,
    SUM(goals_conceded) AS total_goals_conceded,
    SUM(Points) AS total_points
FROM
    (
        SELECT
            season,
            League,
            HomeTeam AS Team,
            HomeGoals AS goals_scored,
            AwayGoals AS goals_conceded,
            CASE
                WHEN HomeGoals > AwayGoals THEN 3
                WHEN HomeGoals < AwayGoals THEN 0
                ELSE 1
            END AS Points
        FROM
            LeagueGames
        UNION ALL
        SELECT
            season,
            League,
            AwayTeam AS Team,
            AwayGoals AS goals_scored,
            HomeGoals AS goals_conceded,
            CASE
                WHEN HomeGoals < AwayGoals THEN 3
                WHEN HomeGoals > AwayGoals THEN 0
                ELSE 1
            END AS Points
        FROM
            LeagueGames
    )
GROUP BY
    season,
    League,
    Team
ORDER BY
    season,
    League,
    total_points DESC;