require "config/boot"
require "views/app_view"

class App
  def self.call
    app = AppView.new
    app.render
  end
end
