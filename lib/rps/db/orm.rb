require 'pry-byebug'
require 'pg'

# find_open_match >>> checks to see if there is a match with only one player
# assign_new_player >>> assigns second player to match and starts new game
# create_game

module RPS
  class ORM

    def initialize
      @db = PG.connect(host: 'localhost', dbname: 'rps_hack')
      build_tables
    end

    def build_tables
      @db.exec(%Q[
        CREATE TABLE IF NOT EXISTS users (
          id serial NOT NULL PRIMARY KEY,          
          name VARCHAR(30),
          password_digest VARCHAR(100) 
        )])

      @db.exec(%Q[
        CREATE TABLE IF NOT EXISTS matches (
          id serial NOT NULL PRIMARY KEY,
          p1_id integer REFERENCES users(id),
          p2_id integer REFERENCES users(id),
          winner integer REFERENCES users(id)
        )])

      @db.exec(%Q[
        CREATE TABLE IF NOT EXISTS games (
          id serial NOT NULL PRIMARY KEY,
          match_id integer REFERENCES matches(id),
          p1_id integer REFERENCES users(id),
          p2_id integer REFERENCES users(id),
          p1_move VARCHAR(10),
          p2_move VARCHAR(10)
        )])
    end

    # =======================================
    #               Matches
    # =======================================

    def create_match(player_id)
      response = @db.exec_params(%Q[
        INSERT INTO matches(p1_id)
        VALUES ($1)
        RETURNING id;
        ], [player_id])

      response.first["id"]
    end

    def find_open_match

    end

    def assign_new_player(match_id, player_id)
      response = @db.exec_params(%Q[
        UPDATE matches
        SET (p2_id) = ($1)
        WHERE id = $2;
        ], [match_id, player_id])

      create_game(match_id, p1_id, p2_id)
    end

    # =======================================
    #               Games
    # =======================================


    def create_game(match_id, p1_id, p2_id)
      response = @db.exec_params(%Q[
        INSERT INTO games(match_id, p1_id, p2_id)
        VALUES ($1, $2, $3, $4)
        RETURNING id;
        ], [m_id, p1_id, p2_id])

      response.first["id"]
    end

    def update_p1_moves()
      response = db.exec_params(%Q[
        UPDATE games
        SET (p_move) = ($1)
        where id = $2;
        ], [])
    end

    def update_p2_moves()
      response = db.exec_params(%Q[
        UPDATE games
        SET (p_move) = ($1)
        where id = $2;
        ], [])
    end

    # def get_last_game_by_match_id(match_id)

    #   result = @db.exec(%Q[
    #     select m_id, p1_id, p2_id, p1_move, 
    #     p2_move, winner, id from games 
    #     where games.m_id = $1 and winner is null 
    #     ],[match_id])
    
    #   if result.num_tuplas.zero?
    #     return nil
    #   else
    #     game = Game.new(result[0]['m_id'],result[0]['p1_id'],result[0]['p2_id']
    #       ,result[0]['p1_move'],result[0]['p2_move'],nil,result[0]['id'])
    #   end
    # end

    # =======================================
    #            USERS / PLAYERS
    # =======================================

    def create_user(name, password_digest)
      response = @db.exec_params(%Q[
        INSERT INTO users(name, password_digest)
        VALUES ($1, $2)
        RETURNING id;
        ], [name, password_digest])

      response.first["id"]
    end

    def get_player(match_id)

      players = @db.exec(%Q[
        select * from users where 
        id = (select p1_id from matches where id  = $1)
        or
        id = (select p2_id from matches where id  = $1)
        ],[match_id])

      return players
    end

  end

  # =====================================
  
  def self.orm
    @__db_instance ||= ORM.new
  end
end