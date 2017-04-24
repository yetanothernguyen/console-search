require "spec_helper"

require "models/organization"
require "runners/organization_search_runner"

RSpec.describe OrganizationSearchRunner do

  describe "#search_fields" do
    specify do
      expect(OrganizationSearchRunner.new.search_fields).to eq [
        "_id",
        "created_at",
        "details",
        "domain_names",
        "external_id",
        "name",
        "shared_tickets",
        "tags",
        "url",
      ]
    end
  end

  describe "#boolean_fields" do
    specify do
      expect(OrganizationSearchRunner.new.boolean_fields).to eq [
        "shared_tickets"
      ]
    end
  end

  describe "#presenter" do
    specify { expect(OrganizationSearchRunner.new.presenter).to eq OrganizationPresenter }
  end

  it_behaves_like "a searchable object", Organization, "name", "An Organization"
  it_behaves_like "a searchable object with boolean fields", Organization, "shared_tickets", "true", true

end
