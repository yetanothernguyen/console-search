require "spec_helper"

require "models/user"
require "models/organization"
require "models/ticket"
require "presenters/ticket_presenter"

RSpec.describe TicketPresenter do

  it_behaves_like "a presentable object"

  describe "#listing_header" do
    specify { expect(TicketPresenter.listing_header).to eq ["Id", "Subject"] }
  end

  describe "#listing_row" do
    let(:user) { Ticket.new(id: 1, subject: "A ticket") }
    specify { expect(TicketPresenter.new(user).listing_row).to eq [1, "A ticket"] }
  end

  describe "#details" do
    let(:assignee) { User.new(id: 1, name: "Assignee") }
    let(:submitter) { User.new(id: 2, name: "Submitter") }
    let(:org) { Organization.new(id: 1, name: "Organization 1") }

    let(:ticket) do
      Ticket.new(
        _id: "436bf9b0-1147-4c0a-8439-6f79833bff5b",
        url: "http://initech.zendesk.com/api/v2/tickets/436bf9b0-1147-4c0a-8439-6f79833bff5b.json",
        external_id: "9210cdc9-4bee-485f-a078-35396cd74063",
        created_at: "2016-04-28T11:19:34 -10:00",
        type: "incident",
        subject: "A Catastrophe in Korea (North)",
        description: "Nostrud ad sit velit cupidatat laboris ipsum nisi amet laboris ex exercitation amet et proident. Ipsum fugiat aute dolore tempor nostrud velit ipsum.",
        priority: "high",
        status: "pending",
        submitter: submitter,
        assignee: assignee,
        organization: org,
        tags: [
          "Ohio",
          "Pennsylvania",
          "American Samoa",
          "Northern Mariana Islands"
        ],
        has_incidents: false,
        due_at: "2016-07-31T02:37:50 -10:00",
        via: "web"
      )
    end

    let(:expected_details) do
      [
        ["_id", "436bf9b0-1147-4c0a-8439-6f79833bff5b"],
        ["url", "http://initech.zendesk.com/api/v2/tickets/436bf9b0-1147-4c0a-8439-6f79833bff5b.json"],
        ["external_id", "9210cdc9-4bee-485f-a078-35396cd74063"],
        ["type", "incident"],
        ["subject", "A Catastrophe in Korea (North)"],
        ["description", "Nostrud ad sit velit cupidatat laboris ipsum nisi amet laboris ex exercitation amet et proident. Ipsum fugiat aute dolore tempor nostrud velit ipsum."],
        ["priority", "high"],
        ["status", "pending"],
        ["tags", "[\"Ohio\", \"Pennsylvania\", \"American Samoa\", \"Northern Mariana Islands\"]"],
        ["has_incidents", false],
        ["via", "web"],
        ["created_at", DateTime.parse("2016-04-28 21:19:34 UTC")],
        ["due_at", DateTime.parse("2016-07-31 12:37:50 UTC")],
        ["submitter_id", 2],
        ["assignee_id", 1],
        ["organization_id", 1],
        ["organization_name", "Organization 1"],
        ["submitter_name", "Submitter"],
        ["assignee_name", "Assignee"]]
    end

    it "returns details correctly" do
      expect(TicketPresenter.new(ticket).details).to eq expected_details
    end
  end
end
