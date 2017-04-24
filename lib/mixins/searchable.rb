require "errors/invalid_search_field"

module Searchable

  def search(field, value)
    raise InvalidSearchField, "#{field} is not a valid search field" unless search_fields.include?(field)

    search_class.where(
      sanitize_field(field) => sanitize_value(field, value)
    )
  end

  def sanitize_field(field)
    field
  end

  def sanitize_value(field, value)
    return "" if value.nil?
    if boolean_fields.include?(field)
      return true if value.casecmp("true")
      return false if value.casecmp("false")
    else
      value
    end
  end

  def boolean_fields
    []
  end

  def search_class
    raise NotImplementedError
  end

  def search_fields
    search_class.column_names.sort
  end

  def presenter
    raise NotImplementedError
  end

end
