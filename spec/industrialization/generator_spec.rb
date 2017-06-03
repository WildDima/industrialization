require 'spec_helper'

RSpec.describe Industrialization::Generator do
  let(:object_attributes) { { a1: 1, a2: '12', a3: nil, a4: { a5: 'sdsa das' } } }
  let(:object) { double('TestObject', object_attributes) }
  subject { described_class.new(obj: object) }
  let(:rendered_string) do
    "FactoryGirl.define do\n"\
    "  factory :r_spec_mocks_double, class: 'RSpec::Mocks::Double' do\n"\
    "      a1 1\n"\
    "      a2 '12'\n"\
    "      a3 nil\n"\
    "      a4 {{:a5=>\"sdsa das\"}}\n"\
    "  end\n"\
    'end'
  end

  before do
    allow(object).to receive(:serializable_hash) { object_attributes }
  end

  it 'does return correct factory data' do
    expect(subject.render).to eq(rendered_string)
  end

  context 'object without namespace' do
    subject { described_class.new(obj: {}) }

    describe '#object_name' do
      it 'does return class name' do
        subject { described_class.new(obj: object) }

        expect(subject.object_name).to eq('hash')
      end
    end

    describe '#class_name' do
      it 'does return empty string' do
        expect(subject.class_name).to eq(' ')
      end
    end
  end

  context 'object with namespace' do
    describe '#object_name' do
      it 'does return class name' do
        subject { described_class.new(obj: object) }

        expect(subject.object_name).to eq('r_spec_mocks_double')
      end
    end

    describe '#class_name' do
      it 'does return class name' do
        subject { described_class.new(obj: object) }

        expect(subject.class_name).to eq(", class: 'RSpec::Mocks::Double'")
      end
    end
  end
end
