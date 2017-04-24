RSpec.shared_examples_for "a searchable object" do |klass, field, value|
  let(:searchable) { described_class.new }
  let(:result) { klass.new(field => value) }

  it { expect(searchable).to respond_to(:search_class) }
  it { expect(searchable).to respond_to(:presenter) }

  it "and returns search result" do
    expect(klass).to receive(:where).with(field => value).and_return([result])
    expect(searchable.search(field, value)).to eq [result]
  end
end

RSpec.shared_examples_for "a searchable object with boolean fields" do |klass, field, value, value_b|
  let(:searchable) { described_class.new }
  let(:result) { klass.new(field => value) }

  it "and returns search result" do
    expect(klass).to receive(:where).with(field => value_b).and_return([result])
    expect(searchable.search(field, value)).to eq [result]
  end
end
