require 'spec_helper'

RSpec.describe Industrialization::Attributes do
  # TODO: refactor it
  let(:except_attributes) do
    {
      'created_at' => '1',
      'updated_at' => '1',
      'id' => '1'
    }
  end

  let(:attributes) do
    { a1: 1, a2: '12', a3: nil,
      a4: { a5: 'sdsa das', a6: { a7: [] }, a8: [1, 2, 3] } }
  end

  subject do
    described_class.new(attributes: attributes.merge(except_attributes))
  end

  it 'does return modified hash' do
    expect(subject.each.to_h).to eq(attributes)
  end
end
