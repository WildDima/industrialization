require 'spec_helper'

RSpec.describe Industrialization::Partial::Hash do
  it_behaves_like 'partial', described_class

  let(:attr) { 'test_attr' }
  let(:value) { 'test_value' }
  let(:rendered) { 'test_attr {test_value}' }
  subject { described_class.new(attr: attr, value: value) }

  it 'does return partial' do
    expect(subject.render).to eq(rendered)
  end
end