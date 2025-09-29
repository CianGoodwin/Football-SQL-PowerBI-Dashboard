-- SQLite
DROP VIEW IF EXISTS LeagueGames;

CREATE VIEW
    LeagueGames AS
SELECT
    lg.Season AS Season,
    lg.league AS League,
    ht.name AS HomeTeam,
    at.name AS AwayTeam,
    lg.HomeGoals AS HomeGoals,
    lg.AwayGoals AS AwayGoals,
    CASE
        WHEN lg.HomeGoals > lg.AwayGoals THEN ht.name
        WHEN lg.HomeGoals < lg.AwayGoals THEN at.name
        ELSE 'Draw'
    END AS Result
FROM
    (
        SELECT
            CASE
                WHEN season = '2014' THEN '2014/2015'
                WHEN season = '2015' THEN '2015/2016'
                WHEN season = '2016' THEN '2016/2017'
                WHEN season = '2017' THEN '2017/2018'
                WHEN season = '2018' THEN '2018/2019'
                WHEN season = '2019' THEN '2019/2020'
                WHEN season = '2020' THEN '2020/2021'
            END AS Season,
            l.name AS league,
            g.gameID AS gameID,
            g.HomeTeamID AS HomeTeamID,
            g.AwayTeamID AS AwayTeamID,
            g.HomeGoals AS HomeGoals,
            g.AwayGoals AS AwayGoals
        FROM
            leagues l
            JOIN games g ON l.leagueID = g.leagueID
    ) AS lg
    JOIN teams ht ON lg.HomeTeamID = ht.teamID
    JOIN teams at ON lg.AwayTeamID = at.teamID;

SELECT
    *
FROM
    LeagueGames;