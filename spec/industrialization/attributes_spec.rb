require 'spec_helper'

RSpec.describe Industrialization::Attributes do
  let(:attributes) { { a1: 1, a2: '12', a3: nil, a4: { a5: 'sdsa das' } } }
  let(:modified_attributes) { { a1: 1, a2: "'12'", a3: 'nil', a4: { a5: "'sdsa das'" } } }
  subject { described_class.new(attributes: attributes) }

  it 'does return modified hash' do
    expect(subject.modified_attributes).to eq(modified_attributes)
  end
end
