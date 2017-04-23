require "models/organization"
require "mixins/json_loadable"

class OrganizationJsonLoader
  include JsonLoadable

  def model
    Organization
  end

  def filter_attributes(json)
    json.except("_id").merge(
      "id" => json["_id"]
    )
  end
end
