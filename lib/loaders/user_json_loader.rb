require "models/user"
require "mixins/json_loadable"

class UserJsonLoader
  include JsonLoadable

  def model
    User
  end

  def filter_attributes(json)
    json.except("_id").merge(
      "id" => json["_id"]
    )
  end
end
