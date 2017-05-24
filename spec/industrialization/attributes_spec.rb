require 'spec_helper'

RSpec.describe Industrialization::Attributes do
  let(:attributes) do
    { a1: 1, a2: '12', a3: nil,
      a4: { a5: 'sdsa das', a6: { a7: [] }, a8: [1, 2, 3] } }
  end

  let(:modified_attributes) do
    { a1: 1, a2: "'12'", a3: 'nil',
      a4: { a5: "'sdsa das'", a6: { a7: [] }, a8: [1, 2, 3] } }
  end

  subject { described_class.new(attributes: attributes) }

  it 'does return modified hash' do
    expect(subject.modified_attributes).to eq(modified_attributes)
  end
end
