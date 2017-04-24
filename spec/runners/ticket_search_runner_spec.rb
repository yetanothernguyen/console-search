require "spec_helper"

require "models/ticket"
require "runners/ticket_search_runner"

RSpec.describe TicketSearchRunner do

  describe "#search_fields" do
    specify do
      expect(TicketSearchRunner.new.search_fields).to eq [
        "_id",
        "assignee_id",
        "created_at",
        "description",
        "due_at",
        "external_id",
        "has_incidents",
        "organization_id",
        "priority",
        "status",
        "subject",
        "submitter_id",
        "tags",
        "type",
        "url",
        "via"
      ]
    end
  end

  describe "#boolean_fields" do
    specify do
      expect(TicketSearchRunner.new.boolean_fields).to eq [
        "has_incidents"
      ]
    end
  end

  describe "#presenter" do
    specify { expect(TicketSearchRunner.new.presenter).to eq TicketPresenter }
  end

  it_behaves_like "a searchable object", Ticket, "subject", "A ticket"
  it_behaves_like "a searchable object with boolean fields", Ticket, "has_incidents", "true", true

end
