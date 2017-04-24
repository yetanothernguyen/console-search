RSpec.shared_examples "a presentable object" do
  let(:presentable) { described_class.new(nil) }

  it { expect(described_class).to respond_to(:listing_header) }
  it { expect(presentable).to respond_to(:listing_row) }
  it { expect(presentable).to respond_to(:details) }
end
