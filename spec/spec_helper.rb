require "yaml"
require "active_record"

Dir[Pathname.new(File.dirname(__FILE__)).join("support/**/*.rb")].each { |f| require f }

configuration = YAML::load(IO.read('config/database.yml'))
ActiveRecord::Base.establish_connection(configuration)