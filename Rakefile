task :default => [:run]

desc "Run app"
task "run" do
  $LOAD_PATH.unshift(File.dirname(__FILE__), "lib")
  require 'app'

  App.call
end

desc "Setup database"
task "db:setup" do
  $LOAD_PATH.unshift(File.dirname(__FILE__), "lib")
  require "config/boot"
  require "loaders/organization_json_loader"
  require "loaders/user_json_loader"
  require "loaders/ticket_json_loader"

  ActiveRecord::Migrator.migrate('db/migrate')

  json = File.read("db/fixtures/organizations.json")
  loader = OrganizationJsonLoader.new(json)
  loader.load

  json = File.read("db/fixtures/users.json")
  loader = UserJsonLoader.new(json)
  loader.load

  json = File.read("db/fixtures/tickets.json")
  loader = TicketJsonLoader.new(json)
  loader.load
end
