require 'pry-byebug'
require 'pg'

module RPS
  class ORM

    def initialize
      @db = PG.connect(host: 'localhost', dbname: 'rps_hack')
      build_tables
    end

    def build_tables
      @db.exec(%Q[
        CREATE TABLE IF NOT EXISTS users (
          name VARCHAR(30),
          password_digest VARCHAR(30), 
          id serial NOT NULL PRIMARY KEY
        )])

      @db.exec(%Q[
        CREATE TABLE IF NOT EXISTS matches (
          p1_id integer REFERENCES users(id),
          p2_id integer REFERENCES users(id),
          winner integer REFERENCES users(id),
          id serial NOT NULL PRIMARY KEY  
        )])

      @db.exec(%Q[
        CREATE TABLE IF NOT EXISTS games (
          m_id integer REFERENCES matches(id),
          p1_id integer REFERENCES users(id),
          p2_id integer REFERENCES users(id),
          p1_move VARCHAR(15),
          p2_move VARCHAR(15),
          winner integer REFERENCES users(id)
          id serial NOT NULL PRIMARY KEY
        )])

    end

    def get_last_game_by_match_id(match_id)

      result = @db.exec(%Q[
        select m_id, p1_id, p2_id, p1_move, 
        p2_move, winner, id from games 
        where games.m_id = $1 and winner is null 
        ],[match_id])
    
      if result.num_tuplas.zero?
        return nil
      else
        game = Game.new(result[0]['m_id'],result[0]['p1_id'],result[0]['p2_id']
          ,result[0]['p1_move'],result[0]['p2_move'],nil,result[0]['id'])
      end
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
  
  def self.ORM
    @__db_instance ||= ORM.new
  end
end