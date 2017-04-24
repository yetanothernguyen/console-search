require "mixins/searchable"
require "presenters/organization_presenter"

class OrganizationSearchRunner
  include Searchable

  def presenter
    OrganizationPresenter
  end

  def search_class
    Organization
  end

  def search_fields
    super.map { |c| c == "id" ? "_id" : c }.sort
  end

  def boolean_fields
    %w(shared_tickets)
  end

  def sanitize_field(field)
    return nil if field.nil?
    field == "_id" ? "id" : field
  end
end
