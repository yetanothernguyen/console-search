require "spec_helper"
require "views/list_view"
require "tty/test_prompt"

require "models/organization"
require "presenters/organization_presenter"

RSpec.describe ListView do

  let(:prompt) { TTY::TestPrompt.new }
  let(:presenter) { OrganizationPresenter }
  let(:item1) { Organization.new(id: 101, name: "Organization 1") }
  let(:item2) { Organization.new(id: 102, name: "Organization 2") }
  let(:results) { Kaminari::PaginatableArray.new([item1, item2]) }

  describe "#render" do
    it "renders list" do
      view = ListView.new(prompt, results, presenter)

      expect(view).to receive(:done).and_return(true)
      expect(view).to receive(:refresh).and_return(1)

      view.render

      expect(prompt.output.string).to include("Id")
      expect(prompt.output.string).to include("Name")
      expect(prompt.output.string).to include("Organization 1")
      expect(prompt.output.string).to include("Organization 2")
      expect(prompt.output.string).to include("Showing 1-2 of 2 items")
    end
  end
end
