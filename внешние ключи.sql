-- внешние ключи
ALTER TABLE clubs
   ADD CONSTRAINT clubs_liga_id_fk
       FOREIGN KEY (liga_id) REFERENCES ligues(id);
       
      
  -- внешние ключи связи клубов и игроков    
ALTER TABLE clubs_players
   ADD CONSTRAINT clubs_players_id_fk
       FOREIGN KEY (club_id) REFERENCES clubs(id),
   ADD CONSTRAINT players_clubs_id_fk
       FOREIGN KEY (player_id) REFERENCES players(id);
       
      
      
-- внешние ключи для таблицы игроков 
 ALTER TABLE players_detales
   ADD CONSTRAINT players_detales_player_id_fk
       FOREIGN KEY (player_id) REFERENCES players(id)
       ON DELETE CASCADE,
   ADD CONSTRAINT players_detales_role_id_fk
       FOREIGN KEY (role_id) REFERENCES roles(id),     
   ADD CONSTRAINT players_detales_photo_id_fk
   	   FOREIGN KEY (photo_id) REFERENCES players_photos(id);
   	  

   	  
   	  
 -- внешние ключи для таблицы игр	  
ALTER TABLE games
   ADD CONSTRAINT games_club_1_id_fk
       FOREIGN KEY (club_1_id) REFERENCES clubs(id),
   ADD CONSTRAINT games_club_2_id_fk
       FOREIGN KEY (club_2_id) REFERENCES clubs(id),
   ADD CONSTRAINT type_result_id_fk
       FOREIGN KEY (type_result_id) REFERENCES type_results(id);
      
      -- внешние ключи для таблицы медиа
      
 ALTER TABLE media 
   ADD CONSTRAINT media_game_id_fk
       FOREIGN KEY (game_id) REFERENCES games(id),
   ADD CONSTRAINT media_type_id_fk
       FOREIGN KEY (media_type_id) REFERENCES media_types(id);
         
      -- внешние ключи для таблицы голов   
      
   ALTER TABLE goals
   ADD CONSTRAINT players_goals_id_fk
       FOREIGN KEY (player_id) REFERENCES players(id),
   ADD CONSTRAINT games_goals_id_fk
       FOREIGN KEY (game_id) REFERENCES games(id);
 