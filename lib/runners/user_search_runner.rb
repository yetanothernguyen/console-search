require "mixins/searchable"
require "presenters/user_presenter"

class UserSearchRunner
  include Searchable

  def presenter
    UserPresenter
  end

  def search_class
    User
  end

  def search_fields
    super.map { |c| c == "id" ? "_id" : c }.sort
  end

  def boolean_fields
    %w(active verified shared suspended)
  end

  def sanitize_field(field)
    return nil if field.nil?
    field == "_id" ? "id" : field
  end

end
