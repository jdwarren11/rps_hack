require 'pry-byebug'
require 'pg'

module RPS
  class ORM

    def initialize
      @db = PG.connect(host: 'localhost', dbname: '')
      build_tables
    end

    def build_tables

    end
    

  end
  
  def self.ORM
    @__db_instance ||= ORM.new
  end
end