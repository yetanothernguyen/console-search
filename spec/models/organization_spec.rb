require "spec_helper"
require "models/organization"

RSpec.describe Organization do

  it "has_many :users" do
    expect(Organization.reflect_on_association(:users).macro).to eq :has_many
  end

end