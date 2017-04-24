RSpec.shared_examples_for "a json_loadable object" do |model, json, expected_attributes|
  let(:json_loadable) { described_class.new(json) }

  it { expect(json_loadable).to respond_to(:model) }

  it "calls create with the correct attributes" do
    expect(model).to receive(:create).with(expected_attributes)
    json_loadable.load
  end
end