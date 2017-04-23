require "models/ticket"
require "mixins/json_loadable"

class TicketJsonLoader
  include JsonLoadable

  def model
    Ticket
  end

end
