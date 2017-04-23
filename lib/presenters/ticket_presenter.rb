class TicketPresenter < SimpleDelegator
  def self.listing_header
    ["Id", "Subject"]
  end

  def listing_row
    [id, subject]
  end

  def details
    attributes.except("id").map { |key, value| [key, value] } +
      [
        ["organization_name", organization.name],
        ["submitter_name", submitter.name],
        ["assignee_name", assignee.name]
      ]
  end
end
