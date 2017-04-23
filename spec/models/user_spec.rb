require "spec_helper"
require "models/user"

RSpec.describe User do

  it "belongs_to :organization" do
    expect(User.reflect_on_association(:organization).macro).to eq :belongs_to
  end

  it "has_many :assigned_tickets" do
    expect(User.reflect_on_association(:assigned_tickets).macro).to eq :has_many
  end

  it "has_many :submitted_tickets" do
    expect(User.reflect_on_association(:submitted_tickets).macro).to eq :has_many
  end

end