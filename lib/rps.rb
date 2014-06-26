module RPS
  def self.db
    @__db_instance ||= Databases::InMemory.new
  end
end

require_relative 'game.rb'
require_relative 'match.rb'
require_relative 'users.rb'
require_relative ''


DIR["#{File.dirname(__FILE__)}/rps/folder/*.rb"].each { |f| require(f) }