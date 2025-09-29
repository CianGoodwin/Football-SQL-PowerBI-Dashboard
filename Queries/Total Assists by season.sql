-- SQLite
-- SQLite
SELECT
    lg.season,
    lg.LeagueName,
    p.name AS PlayerName,
    COUNT(*) AS TotalAssists
FROM
    (
        SELECT
            g.gameID,
            l.name AS LeagueName,
            CASE
                WHEN season = '2014' THEN '2014/2015'
                WHEN season = '2015' THEN '2015/2016'
                WHEN season = '2016' THEN '2016/2017'
                WHEN season = '2017' THEN '2017/2018'
                WHEN season = '2018' THEN '2018/2019'
                WHEN season = '2019' THEN '2019/2020'
                WHEN season = '2020' THEN '2020/2021'
            END AS season
        FROM
            games g
            JOIN teams ht ON g.homeTeamID = ht.teamID
            JOIN leagues l ON g.leagueID = l.leagueID
            JOIN teams at ON g.awayTeamID = at.teamID
    ) AS lg
    JOIN shots s ON lg.gameID = s.gameID
    JOIN players p ON s.assisterID = p.playerID
WHERE
    s.shotResult = 'Goal'
    AND s.assisterID IS NOT NULL
GROUP BY
    lg.season,
    lg.LeagueName,
    p.playerID