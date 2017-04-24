module JsonLoadable

  def initialize(json)
    @json = json
  end

  def model
    raise NotImplementedError
  end

  def filter_attributes(json)
    json
  end

  def load
    parsed = JSON.parse(@json)
    parsed.each do |json_item|
      model.create(filter_attributes(json_item))
    end
  end

end
