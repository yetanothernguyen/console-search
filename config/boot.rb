require "yaml"
require "active_record"
require "sqlite3"

configuration = YAML::load(IO.read("config/database.yml"))
ActiveRecord::Base.establish_connection(configuration)