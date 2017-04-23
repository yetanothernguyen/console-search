require "spec_helper"

require "models/user"
require "models/organization"
require "models/ticket"
require "presenters/user_presenter"

RSpec.describe UserPresenter do

  it_behaves_like "a presentable object"

  describe "#listing_header" do
    specify { expect(UserPresenter.listing_header).to eq ["Id", "Name", "Email"] }
  end

  describe "#listing_row" do
    let(:user) { User.new(id: 1, name: "John Doe", email: "john@example.com") }
    specify { expect(UserPresenter.new(user).listing_row).to eq [1, "John Doe", "john@example.com"] }
  end

  describe "#details" do
    let(:assigned_ticket_1) { Ticket.new(subject: "Assigned Ticket 1") }
    let(:assigned_ticket_2) { Ticket.new(subject: "Assigned Ticket 2") }
    let(:submitted_ticket_1) { Ticket.new(subject: "Submitted Ticket 1") }
    let(:submitted_ticket_2) { Ticket.new(subject: "Submitted Ticket 2") }
    let(:org) { Organization.new(id: 1, name: "Organization 1") }

    let(:user) do
      User.new(
        id: 1,
        url: "http://initech.zendesk.com/api/v2/users/1.json",
        external_id: "74341f74-9c79-49d5-9611-87ef9b6eb75f",
        name: "Francisca Rasmussen",
        alias: "Miss Coffey",
        created_at: "2016-04-15T05:19:46 -10:00",
        active: true,
        verified: true,
        shared: false,
        locale: "en-AU",
        timezone: "Sri Lanka",
        last_login_at: "2013-08-04T01:03:27 -10:00",
        email: "coffeyrasmussen@flotonic.com",
        phone: "8335-422-718",
        signature: "Don't Worry Be Happy!",
        organization_id: 119,
        tags: [
          "Springville",
          "Sutton",
          "Hartsville/Hartley",
          "Diaperville"
        ],
        suspended: true,
        role: "admin",
        organization: org,
        assigned_tickets: [assigned_ticket_1, assigned_ticket_2],
        submitted_tickets: [submitted_ticket_1, submitted_ticket_2],
      )
    end

    let(:expected_details) do
      [
        ["id", 1],
        ["url", "http://initech.zendesk.com/api/v2/users/1.json"],
        ["external_id", "74341f74-9c79-49d5-9611-87ef9b6eb75f"],
        ["name", "Francisca Rasmussen"],
        ["alias", "Miss Coffey"],
        ["active", true],
        ["verified", true],
        ["shared", false],
        ["locale", "en-AU"],
        ["timezone", "Sri Lanka"],
        ["email", "coffeyrasmussen@flotonic.com"],
        ["phone", "8335-422-718"],
        ["signature", "Don't Worry Be Happy!"],
        ["tags", "[\"Springville\", \"Sutton\", \"Hartsville/Hartley\", \"Diaperville\"]"],
        ["suspended", true],
        ["role", "admin"],
        ["created_at", DateTime.parse("2016-04-15T05:19:46 -10:00")],
        ["last_login_at", DateTime.parse("2013-08-04T01:03:27 -10:00")],
        ["organization_id", 1],
        ["organization_name", "Organization 1"],
        ["assigned_ticket_0", "Assigned Ticket 1"],
        ["assigned_ticket_1", "Assigned Ticket 2"],
        ["submitted_ticket_0", "Submitted Ticket 1"],
        ["submitted_ticket_1", "Submitted Ticket 2"]
      ]
    end

    it "returns details correctly" do
      expect(UserPresenter.new(user).details).to eq expected_details
    end
  end
end
