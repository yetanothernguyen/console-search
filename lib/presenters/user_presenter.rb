class UserPresenter < SimpleDelegator
  def self.listing_header
    ["Id", "Name", "Email"]
  end

  def listing_row
    [id, name, email]
  end

  def details
    attributes.map { |key, value| [key, value] } +
      [["organization_name", organization_name]] +
      assigned_ticket_details +
      submitted_ticket_details
  end

  def organization_name
    organization.name
  end

  def assigned_ticket_details
    assigned_tickets.each_with_index.map do |ticket, index|
      ["assigned_ticket_#{index}", ticket.subject]
    end
  end

  def submitted_ticket_details
    submitted_tickets.each_with_index.map do |ticket, index|
      ["submitted_ticket_#{index}", ticket.subject]
    end
  end
end
