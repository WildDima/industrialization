require 'spec_helper'

RSpec.shared_examples 'partial' do |partial|
  let(:attr) { 'shared_example_attr' }
  let(:value) { 'shared_example_value' }
  subject { partial.new(attr: attr, value: value) }

  it 'does return partial name' do
    expect(subject.partial).to be_a Symbol
  end
end
