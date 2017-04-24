require "spec_helper"

require "models/user"
require "runners/user_search_runner"

RSpec.describe UserSearchRunner do

  describe "#search_fields" do
    specify do
      expect(UserSearchRunner.new.search_fields).to eq [
        "_id",
        "active",
        "alias",
        "created_at",
        "email",
        "external_id",
        "last_login_at",
        "locale",
        "name",
        "organization_id",
        "phone",
        "role",
        "shared",
        "signature",
        "suspended",
        "tags",
        "timezone",
        "url",
        "verified"
    ]
    end
  end

  describe "#boolean_fields" do
    specify do
      expect(UserSearchRunner.new.boolean_fields).to eq [
        "active",
        "verified",
        "shared",
        "suspended"
      ]
    end
  end

  describe "#presenter" do
    specify { expect(UserSearchRunner.new.presenter).to eq UserPresenter }
  end

  # let(:user) { User.new(email: "user@example.com", active: true) }
  it_behaves_like "a searchable object", User, "email", "user@example.com"
  it_behaves_like "a searchable object with boolean fields", User, "active", "true", true

  # describe "#search" do
  #   let(:user) { User.new(email: "user@example.com", active: true) }

  #   it "returns results" do
  #     expect(User).to receive(:where).with("email" => "user@example.com").and_return([user])

  #     runner = UserSearchRunner.new
  #     expect(runner.search("email", "user@example.com")).to eq [user]
  #   end

  #   context "when searching for boolean field" do
  #     it "converts search value to boolean" do
  #       expect(User).to receive(:where).with("active" => true).and_return([user])

  #       runner = UserSearchRunner.new
  #       expect(runner.search("active", "true")).to eq [user]
  #     end
  #   end
  # end
end
