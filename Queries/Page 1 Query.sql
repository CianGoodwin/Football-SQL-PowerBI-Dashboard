SELECT
    xg.*,
    l.name AS league_name
FROM
    (
        SELECT
            COUNT(*) AS Appearances,
            p.name AS player_name,
            SUM(a.goals) AS Goals,
            --round(SUM(a.xGoals), 1) AS xGoals,
            --round(SUM(a.goals) - SUM(a.xGoals), 1) AS Overperformance_of_xGoals,
            SUM(a.assists) AS Assists,
            --round(SUM(a.xAssists), 1) AS xAssists,
            --round(SUM(a.assists) - SUM(a.xAssists), 1) AS Overperformance_of_xAssists,
            sum(a.redCard) AS "Red Cards",
            sum(a.yellowCard) AS "Yellow Cards",
            CASE
                WHEN a.position = 'GK' THEN 'Goalkeeper'
                WHEN a.position IN ('DR', 'DL', 'DC') THEN 'Defender'
                WHEN a.position IN ('DMC', 'DMR', 'DML') THEN 'Defensive Midfielder'
                WHEN a.position IN ('MR', 'ML', 'MC') THEN 'Midfielder'
                WHEN a.position IN ('AMR', 'AML', 'AMC') THEN 'Attacking Midfielder'
                WHEN a.position IN ('FWR', 'FWL', 'FW') THEN 'Forward'
                ELSE a.position
            END AS position_group,
            a.leagueID
        FROM
            appearances a
            JOIN players p ON a.playerID = p.playerID
        GROUP BY
            a.leagueID,
            a.playerID,
            position_group
    ) xg
    JOIN leagues l ON xg.leagueID = l.leagueID
ORDER BY
    xg.player_name
