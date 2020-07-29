DROP TABLE IF EXISTS clubs;
CREATE TABLE clubs (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  liga_id INT UNSIGNED NOT NULL COMMENT "ссылка на лигу",
  name VARCHAR(100) NOT NULL COMMENT "Имя клуба",
  city VARCHAR(130) COMMENT "Город",
  country VARCHAR(130) COMMENT "Страна",
  site VARCHAR(130) COMMENT "сайт",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Клубы";

INSERT INTO
  clubs (liga_id, name, city, country, email, phone)
VALUES
  (1, 'ЦСКА', 'Москва', 'Россия','example1@mail.ru', '23423423423423'),
  (1, 'СКА', 'Санкт-Петербург', 'Россия','exampl2e@mail.ru', '23423423423'),
  (1, 'ДИНАМО МОСКВА', 'Москва', 'Россия','example3@mail.ru', '2342363423423'),
  (1, 'ДИНАМО МИНСК', 'Минск', 'Беларусь','example4@mail.ru', '2342123423423'),
  (1, 'ДИНАМО РИГА', 'рига', 'Латвия','example5@mail.ru', '23423428923423'),
  (1, 'ВИТЯЗЬ', 'Москва', 'Россия','example6@mail.ru', '234234234234723'),
  (1, 'ТОРПЕДО', 'Нижний Новгород', 'Россия','example7@mail.ru', '56723423423423'),
  (1, 'ЙОКЕРИТ', 'ХЕЛЬСИНКИ', 'Финляндия','example8@mail.ru', '23423923423423'),
  (1, 'Хк сочи', 'Сочи', 'Россия','example9@mail.ru', '23423423423428'),
  (1, 'Локомотив', 'Ярославль', 'Россия','example10@mail.ru', '23423723423423'),
  (1, 'Северсталь', 'Череповец', 'Россия','example11@mail.ru', '23426423423423'),
  (1, 'Спартак', 'Москва', 'Россия','example12@mail.ru', '23423423428423');
 
 
INSERT INTO
  clubs (liga_id, name, city, country, email, phone)
VALUES
  (2, 'Амур', 'Хабаровск', 'Россия','example191@mail.ru', '234234234233423'),
  (2, 'Ак-Барс', 'Казань', 'Россия','exampl12e@mail.ru', '234234234423'),
  (2, 'Барыс', 'Нурсултан', 'Казахстан','example13@mail.ru', '23423635423423'),
  (2, 'Адмирал', 'Владивосток', 'Россия','example14@mail.ru', '23421232423423'),
  (2, 'Авангард', 'Омск', 'Россия','example15@mail.ru', '234234289234213'),
  (2, 'Сибирь', 'Новосибирск', 'Россия','example16@mail.ru', '2342342342344723'),
  (2, 'Автомобилист', 'Екатеринбург', 'Россия','example17@mail.ru', '567253423423423'),
  (2, 'Салават-Юлаев', 'Уфа', 'Россия','example18@mail.ru', '234239234234223'),
  (2, 'Кунь-Лунь РС', 'Пекин', 'Китай','example19@mail.ru', '234234234232428'),
  (2, 'Трактор', 'Челябинск', 'Россия','example20@mail.ru', '234237234ее23423'),
  (2, 'Нефтехимик', 'Нижнекамск', 'Россия','example21@mail.ru', '234264234232423'),
  (2, 'Металлург МГ', 'Магнитогорск', 'Россия','example22@mail.ru', '234234231428423');

      -- создаем 2 лиги 
DROP TABLE IF EXISTS ligues;           
 CREATE TABLE ligues (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR (100),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
  ) COMMENT "таблица лиг";
 
 INSERT INTO ligues(name) VALUES ('Запад'), ('Восток');

----------------------------------------------------------------------------------------------------------------------------------------

-- Создаём базовую таблицу игроков
DROP TABLE IF EXISTS players;
CREATE TABLE players(
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  first_name VARCHAR(100) NOT NULL COMMENT "Имя игрока",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия игрока",
  player_number INT UNSIGNED NOT NULL COMMENT "Номер игрока",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "игроки";  


-- Таблица игроков подробная
DROP TABLE IF EXISTS players_detales;
CREATE TABLE players_detales (
  player_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на игрока", 
  birthday DATE COMMENT "Дата рождения",
  photo_id INT UNSIGNED COMMENT "Ссылка на основную фотографию пользователя",
  nationality VARCHAR(100) NOT NULL UNIQUE COMMENT "Национальность",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
  shot_on_goals INT UNSIGNED NOT NULL COMMENT "Очки",
  role_id INT UNSIGNED NOT NULL COMMENT "ссылка на амплуа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "подробности про игроков"; 
-- корректируем данные генереруемые фейкером.
UPDATE players_detales SET updated_at = CURRENT_TIMESTAMP WHERE created_at > updated_at;
UPDATE players_detales SET created_at = CURRENT_TIMESTAMP WHERE created_at > birthday ;
UPDATE players_detales SET birthday = '1999-11-12' WHERE birthday > '1999-11-12' ;


-- Таблица связи клубов и игроков
DROP TABLE IF EXISTS clubs_players;
CREATE TABLE clubs_players (
  club_id INT UNSIGNED COMMENT "Ссылка на клуб",
  player_id INT UNSIGNED NOT NULL COMMENT "Ссылка на игрока",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (club_id, player_id) COMMENT "Составной первичный ключ"
) COMMENT "связи игроков и клубов";


-- Таблица амплуа
DROP TABLE IF EXISTS roles;
CREATE TABLE roles (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  role VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
  ) COMMENT "амплуа";

 INSERT INTO roles (role) VALUES 
  ('Вратарь'),
  ('Нападающий'),
  ('защитник');

 -- таблица фото игроков
  DROP TABLE IF EXISTS players_photos;
 CREATE TABLE players_photos (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  filename VARCHAR(255) NOT NULL COMMENT "Путь к файлу",
  size INT NOT NULL COMMENT "Размер файла",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Фото игроков";

UPDATE players_photos SET filename = CONCAT(
 'https://khl.ru/players_photoes/', filename, '.jpeg');


----------------------------------------------------------------------------------------------------------------------------------------   	  
   	  
 
 -- Таблица игр, со счетом
 DROP TABLE IF EXISTS games;
 CREATE TABLE games (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  club_1_id INT UNSIGNED NOT NULL COMMENT "Первый клуб",
  club_2_id INT UNSIGNED NOT NULL COMMENT "второй клуб",
  goals_club_1 INT UNSIGNED NOT NULL DEFAULT 0 COMMENT "Голы первого клуб",
  goals_club_2 INT UNSIGNED NOT NULL DEFAULT 0 COMMENT "Голы второго клуб",
  type_result_id INT UNSIGNED NOT NULL,
  game_media_id VARCHAR(255) NOT NULL COMMENT "медиафайлы игры",
  played_at DATETIME
 ) COMMENT "игры";


-- СОЗДАНИЕ СПРАВОЧНИКА ТИПОВ ПОБЕД 
DROP TABLE IF EXISTS type_results;
CREATE TABLE type_results (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
  ) COMMENT "справочник результата";

 INSERT INTO type_results (name) VALUES 
  ('Победа'),
  ('Поражение'),
  ('Ничья');

UPDATE games SET type_result_id = CASE
WHEN goals_club_1 > goals_club_2 THEN  (SELECT id FROM type_results WHERE name = 'Победа')
WHEN goals_club_1 < goals_club_2 THEN  (SELECT id FROM type_results WHERE name = 'Поражение')
WHEN goals_club_1 = goals_club_2 THEN  (SELECT id FROM type_results WHERE name = 'Ничья')
END;

 
      

-- таблица медиафайлов
DROP TABLE IF EXISTS media;
 CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  game_id INT UNSIGNED NOT NULL COMMENT "Ссылка на игру",
  filename VARCHAR(255) COMMENT "Путь к файлу",
  size INT NOT NULL COMMENT "Размер файла",
  media_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип контента",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки"
) COMMENT "Медиафайлы";


-- Таблица типов медиафайлов
DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа"
) COMMENT "Типы медиафайлов";

INSERT INTO media_types(name) VALUES ('Видео'),('фото');


CREATE TEMPORARY TABLE extensions (name VARCHAR(10));
INSERT INTO extensions VALUES ('JPEG'), ('AVI'), ('MPEG');

UPDATE media SET filename = CONCAT(
 'https://khl.ry/media/',
 filename, '.', (SELECT name FROM extensions ORDER BY RAND() LIMIT 1));

---------------------------------------------------------------------------------------------------------------------------  
-- таблица голов
DROP TABLE IF EXISTS goals;
 CREATE TABLE goals (
  player_id  INT UNSIGNED NOT NULL,
  game_id INT UNSIGNED NOT NULL,
  quantity INT UNSIGNED NOT NULL DEFAULT 0, 
  `time` TIME 
  ) COMMENT "таблица голов";
 -- вратарь не може забивать голов, редактируем его данные на 0
 UPDATE goals SET quantity = 0 WHERE player_id = (SELECT role FROM roles WHERE role = 1);
 

      
----------------------------------------------------------------------------------------------------------------------------------------------      
---- создание таблицы истории трансферов 

DROP TABLE IF EXISTS transfers_archive;
CREATE TABLE transfers_archive (
  created_at DATETIME COMMENT 'время создания записи',
  player_id INT NOT NULL COMMENT 'ид игрока',
  club_id INT NOT NULL COMMENT 'ИЗ какого клуба',
  club2_id INT NOT NULL COMMENT 'в какой клуб'
) ENGINE =Archive;
      
