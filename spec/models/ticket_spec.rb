require "spec_helper"
require "models/ticket"

RSpec.describe Ticket do

  it "belongs_to :organization" do
    expect(Ticket.reflect_on_association(:organization).macro).to eq :belongs_to
  end

  it "belongs_to :submitter" do
    expect(Ticket.reflect_on_association(:submitter).macro).to eq :belongs_to
  end

  it "belongs_to :assignee" do
    expect(Ticket.reflect_on_association(:assignee).macro).to eq :belongs_to
  end


end