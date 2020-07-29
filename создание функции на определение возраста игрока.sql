delimiter //
CREATE FUNCTION `get_age` (
  `date_of_birth` DATE,
  `current_time` DATETIME
) RETURNS INT(11) UNSIGNED DETERMINISTIC NO SQL SQL SECURITY DEFINER
begin
RETURN ((YEAR(current_time) - YEAR(date_of_birth)) - ((DATE_FORMAT(current_time, '00-%m-%d') < DATE_FORMAT(date_of_birth, '00-%m-%d'))));
end//
delimiter ;

SELECT get_age(birthday , NOW()) AS age
FROM players_detales
WHERE player_id = 1;
