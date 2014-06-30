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

    def create_match(p1_id)
      response = @db.exec_params(%Q[
        INSERT INTO matches(p1_id)
        VALUES ($1)
        RETURNING id;
        ], [p1_id])

      response.first["id"]
    end

    def find_open_match
      open_match = @db.exec(%Q[
        select * from matches 
        where p2_id is null;
        ])      
        if open_match.num_tuples.zero?
          return false
        else
          return open_match[0]
        end
    end

    def find_match_by_id(id)
      match = @db.exec(%Q[
        select * from matches 
        where id = $1;
        ],[id])
        
        if match.num_tuples.zero?
          return false
        else
          return match
        end
    end

    def assign_new_player(match_id, player_id)
      @db.exec_params(%Q[
        UPDATE matches
        SET (p2_id) = ($2)
        WHERE id = $1;
        ], [match_id, player_id])

        # match_info = @db.exec_params(%Q[
        #   select p1_id from matches
        #   where id = $1
        #   ],[match_id])
        # create_game(match_id, match_info[0]['p1_id'], player_id)
    end

    def update_winner(id, winner_id)
      response = @db.exec_params(%Q[
        UPDATE matches
        SET (winner) = ($2)
        WHERE id = $1;
        ], [id, winner_id])
    end

    # =======================================
    #               Games
    # =======================================


    def create_game(m_id, p1_id, p2_id)
      response = @db.exec_params(%Q[
        INSERT INTO games(match_id, p1_id, p2_id)
        VALUES ($1, $2, $3)
        RETURNING id;
        ], [m_id, p1_id, p2_id])

      response.first["id"]
    end

    def find_current_game(match_id)
      current_game = @db.exec(%Q[
        select * from games
        where match_id = $1
        and (p2_move is null 
        or p1_move is null)
        ],[match_id])

        if current_game.num_tuples.zero?
          return false
        else
          return current_game
        end
    end

    def update_p1_move(game_id, p_move)
      response = db.exec_params(%Q[
        UPDATE games
        SET (p1_move) = ($2)
        where id = $1;
        ], [game_id, p_move])
    end

    def update_p2_move(game_id, p_move)
      response = db.exec_params(%Q[
        UPDATE games
        SET (p2_move) = ($2)
        where id = $1;
        ], [game_id, p_move])
    end

    def get_games_by_match_id(m_id)
      games = @db.exec_params(%Q[
        SELECT * FROM games
        WHERE match_id = ($1)
        order by id;
        ], [m_id])
      return games
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

    def find_user_by_id(p_id)
      result = @db.exec(%Q[
        SELECT * FROM users
        WHERE id = #{p_id};
        ])
      if result.num_tuples.zero?
        return nil
      else
        build_user(result.first)
      end
    end

    def build_user(attrs)
      RPS::User.new(attrs["name"], attrs["password_digest"], attrs["id"])
    end

    def get_user_by_name(name)
      result = @db.exec_params(%Q[
        SELECT * FROM users
        WHERE name = ($1);
        ], [name])

      if result.num_tuples.zero?
        return nil
      else
        build_user(result.first)
      end
    end

    def get_matches_by_user_id(id)
    result = @db.exec(%Q[
      SELECT * FROM matches
      WHERE p1_id = #{id} or p2_id = #{id}
      ])
      if result.num_tuples.zero?
        return nil
      else
        return result
      end
    end


  end


  # =====================================
  
  def self.orm
    @__db_instance ||= ORM.new
  end
end