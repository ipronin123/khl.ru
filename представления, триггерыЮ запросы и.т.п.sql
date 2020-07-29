-- ПРЕДСТАВЛЕНИЕ ТАБЛИЦЫ 3 ЛИДЕРОВ. (используя join и агрегатную функцию)
CREATE VIEW top_8 AS SELECT clubs.name , 
  COUNT(games.type_result_id ) AS wins
 FROM clubs LEFT JOIN games 
 ON clubs.id = games.club_1_id AND games.type_result_id = 1
 GROUP BY clubs.id
 ORDER BY  wins DESC LIMIT 8;

 
-- Представление таблицы команд их побед пораждений и ничей(статистика). исп. вложенные запросы

SELECT * FROM games g2 ;
CREATE VIEW  statistic AS SELECT name, (
  SELECT COUNT(type_result_id) FROM games WHERE 
    (type_result_id  = 1 ) AND club_1_id = clubs.id ) AS win,
  (SELECT COUNT(type_result_id) FROM games WHERE 
    (type_result_id  = 2) AND club_1_id = clubs.id) AS lose,
  (SELECT COUNT(type_result_id) FROM games WHERE 
    (type_result_id  = 3) AND club_1_id = clubs.id) AS draw,
   (SELECT SUM(goals_club_1 ) FROM games WHERE 
    club_1_id = clubs.id) AS shots_on_goals,
  (SELECT SUM(goals_club_2 ) FROM games WHERE 
    club_1_id = clubs.id) AS "пропущенные голы"
  FROM clubs;



-- 10 самых результативных молодых игроков (Хотел добавить еще колонку принадлежности игрока к клубу, голову сломал, не получилось)
 
SELECT
    (SELECT players_photos.filename FROM players_photos WHERE players_photos.id = goals.player_id ) AS photo ,
	(SELECT players.first_name FROM players WHERE players.id = goals.player_id ) AS first_name ,
	(SELECT players.last_name FROM players WHERE players.id = goals.player_id ) AS last_name ,
	SUM(quantity ) AS total_goals,
	(SELECT get_age(birthday , NOW()) FROM players_detales WHERE players_detales.player_id = goals.player_id) AS age
    FROM goals 
    GROUP BY player_id 
    ORDER BY age, total_goals DESC 
    LIMIT 10;

   WHERE выражение [NOT] IN (выражение)
 
-- транзакции на трансфер игроков (переход игрока из одного клуба в другой)

START TRANSACTION;
SELECT player_id FROM clubs_players WHERE player_id = 18 AND club_id = 20;
UPDATE clubs_players SET club_id = 21 WHERE player_id = 18;
COMMIT;



--- СОЗДАНИЕ ТРИГГЕРА ( КОТОРЫЙ ПЕРЕНОСИТ ИНФОРМАЦИЮ О ТРАНСФЕРЕ ИГРОКА В ТАБЛИЦУ КОТОРАЯ ХРАНИТ ВСЕ ХАПИСИ О ТРАНСФЕРАХ ИГРОКОВ)

DROP TRIGGER IF EXISTS transfer;
DELIMITER //
CREATE TRIGGER transfer AFTER UPDATE ON clubs_players
FOR EACH ROW
BEGIN
	INSERT INTO transfers_archive (created_at, player_id,club_id, club2_id)
	VALUES (NOW(), NEW.player_id, OLD.club_id, NEW.club_id);
END //
DELIMITER ;
-- ВЛОЖЕННЫЙ ЗАПРОС НА 10 САМЫХ РЕЗУЛЬТАТИВНЫХ ИГР.(КТО С КЕМ, СЧЕТ, ссылка на видео(фото) с матча.
SELECT
	(SELECT clubs.name FROM clubs WHERE clubs.id = games.club_1_id ) AS club1,
	(SELECT clubs.name FROM clubs WHERE clubs.id = games.club_2_id ) AS club2,
	CONCAT(games.goals_club_1, ':', games.goals_club_2) AS score,
	(SELECT media.filename FROM media  WHERE media.id = games.game_media_id ) AS media
    FROM games
    ORDER BY score DESC 
    LIMIT 10; 

   
-- кандидаты на вылет из турнира( последние 4 команды в каждой лиге)
SELECT clubs.name , 
  COUNT(games.type_result_id ) AS wins
 FROM clubs JOIN games 
 ON clubs.id = games.club_1_id AND games.type_result_id = 1 AND clubs.liga_id = 1
 GROUP BY clubs.id
 ORDER BY  wins LIMIT 4 ;

SELECT clubs.name , 
  COUNT(games.type_result_id ) AS wins
 FROM clubs JOIN games 
 ON clubs.id = games.club_1_id AND games.type_result_id = 1 AND clubs.liga_id = 2
 GROUP BY clubs.id
 ORDER BY  wins LIMIT 4;
 



  