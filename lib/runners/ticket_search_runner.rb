require "mixins/searchable"
require "presenters/ticket_presenter"

class TicketSearchRunner
  include Searchable

  def presenter
    TicketPresenter
  end

  def search_class
    Ticket
  end

  def search_fields
    super.select { |c| c != "id" }.sort
  end

  def boolean_fields
    %w(has_incidents)
  end

end
