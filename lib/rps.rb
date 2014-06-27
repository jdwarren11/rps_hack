module RPS
end


Dir["#{File.dirname(__FILE__)}/rps/**/*.rb"].each { |f| require(f) }
# DIR["#{File.dirname(__FILE__)}/entities/DB/*.rb"].each { |f| require(f) }
# DIR["#{File.dirname(__FILE__)}/rps/transaction_scripts/*.rb"].each { |f| require(f) }