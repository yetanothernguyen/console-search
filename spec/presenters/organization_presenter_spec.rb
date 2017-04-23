require "spec_helper"

require "models/organization"
require "presenters/organization_presenter"

RSpec.describe OrganizationPresenter do

  it_behaves_like "a presentable object"

  describe "#listing_header" do
    specify { expect(OrganizationPresenter.listing_header).to eq ["Id", "Name"] }
  end

  describe "#listing_row" do
    let(:user) { Organization.new(id: 1, name: "An organization") }
    specify { expect(OrganizationPresenter.new(user).listing_row).to eq [1, "An organization"] }
  end

  describe "#details" do
    let(:organization) do
      Organization.new(
        id: 101,
        url: "http://initech.zendesk.com/api/v2/organizations/101.json",
        external_id: "9270ed79-35eb-4a38-a46f-35725197ea8d",
        name: "Enthaze",
        domain_names: [
          "kage.com",
          "ecratic.com",
          "endipin.com",
          "zentix.com"
        ],
        created_at: "2016-05-21T11:10:28 -10:00",
        details: "MegaCorp",
        shared_tickets: false,
        tags: [
          "Fulton",
          "West",
          "Rodriguez",
          "Farley"
        ]
      )
    end

    let(:expected_details) do
      [
        ["_id", 101],
        ["url", "http://initech.zendesk.com/api/v2/organizations/101.json"],
        ["external_id", "9270ed79-35eb-4a38-a46f-35725197ea8d"],
        ["name", "Enthaze"],
        ["domain_names", "[\"kage.com\", \"ecratic.com\", \"endipin.com\", \"zentix.com\"]"],
        ["details", "MegaCorp"],
        ["shared_tickets", false],
        ["tags", "[\"Fulton\", \"West\", \"Rodriguez\", \"Farley\"]"],
        ["created_at", DateTime.parse("2016-05-21T11:10:28 -10:00")]
      ]
    end

    it "returns details correctly" do
      expect(OrganizationPresenter.new(organization).details).to eq expected_details
    end
  end
end
