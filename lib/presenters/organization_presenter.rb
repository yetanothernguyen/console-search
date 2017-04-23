class OrganizationPresenter < SimpleDelegator
  def self.listing_header
    ["Id", "Name"]
  end

  def listing_row
    [id, name]
  end

  def details
    [["_id", id]] +
      attributes.except("id").map { |key, value| [key, value] }
  end
end
