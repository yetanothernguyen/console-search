require "tty-prompt"

require "models/organization"
require "models/user"
require "models/ticket"
require "presenters/organization_presenter"
require "presenters/user_presenter"
require "presenters/ticket_presenter"
require "runners/organization_search_runner"
require "runners/user_search_runner"
require "runners/ticket_search_runner"
require "views/list_view"

class AppView

  LINES_COUNT = 4 # 3 static questions + new line

  def initialize(prompt = nil)
    @prompt = prompt || TTY::Prompt.new(interrupt: :exit)
    @pastel = Pastel.new
    @done   = false
  end

  def render
    render_welcome
    loop do
      render_search_prompt
      @prompt.print(refresh)
      break if done
    end
  end

  def done
    @done
  end

  private

  def render_welcome
    welcome = "=========================\n" +
      @pastel.yellow('Welcome to Zendesk Search') + "\n" +
      "=========================\n"
    @prompt.print(welcome)
  end

  def render_search_prompt
    chosen_runner = @prompt.select("What do you want to search for?", search_options)
    runner = chosen_runner.new

    field = @prompt.select("Select a search term", runner.search_fields, per_page: 10, quick_list: true)
    value = @prompt.ask("Enter search value")

    results = runner.search(field, value)

    list_view = ListView.new(@prompt, results, runner.presenter)
    list_view.render

    @done = list_view.exit?
  end

  def search_options
    {
      "Users" => UserSearchRunner,
      "Tickets" => TicketSearchRunner,
      "Organizations" => OrganizationSearchRunner
    }
  end

  def refresh
    @prompt.clear_lines(LINES_COUNT)
  end
end
