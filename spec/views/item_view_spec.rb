require "spec_helper"
require "views/item_view"
require "tty/test_prompt"

require "models/organization"
require "presenters/organization_presenter"

RSpec.describe ItemView do

  let(:prompt) { TTY::TestPrompt.new }
  let(:presenter) { OrganizationPresenter }
  let(:item) do
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

  describe "#render" do
    it "renders item fields" do
      prompt.input << "\n"
      prompt.input.rewind

      view = ItemView.new(prompt, item, presenter)

      expect(view).to receive(:done).and_return(true)
      expect(view).to receive(:refresh).and_return(1)

      view.render

      item.attributes.each do |key, value|
        expect(prompt.output.string).to include(key)
        expect(prompt.output.string).to include(value.to_s)
      end
    end
  end
end
