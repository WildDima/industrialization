require 'spec_helper'

RSpec.describe Industrialization::Generator do
  let(:object_attributes) { { a1: 1, a2: '12', a3: nil, a4: { a5: 'sdsa das' } } }
  let(:modified_attributes) { { a1: 1, a2: "'12'", a3: nil, a4: { a5: "'sdsa das'" } } }
  let(:object) { double('TestObject', object_attributes) }
  subject { described_class.new(obj: object) }

  before do
    allow(object).to receive(:serializable_hash) { object_attributes }
  end

  # TODO: write normal specs
  it 'does return correct factory data' do
    # expect(subject.render).to eq("FactoryGirl.define do\n  factory :r_spec/mocks/double do\n    \n      a1 1\n    \n      a2 12\n    \n      a3 \n    \n      a4 {}\n    \n  end\nend")
    expect(subject.render).to be_a String
  end

  describe '#modify_hash' do
    it 'does return correct hash' do
      expect(subject.modify_hash(object_attributes)).to eq(modified_attributes)
    end
  end
end
