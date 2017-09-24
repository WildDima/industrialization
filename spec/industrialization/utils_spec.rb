require 'spec_helper'

RSpec.describe Industry::Utils do
  subject { described_class }

  describe '.underscore' do
    let(:class_name) { 'Asd::Qwqe::DjhjkQwe' }
    let(:class_name_underscored) { 'asd_qwqe_djhjk_qwe' }

    it 'does return correct string' do
      expect(subject.underscore(class_name)).to eq(class_name_underscored)
    end
  end

  describe '.hash_except_keys' do
    let(:hash) { { a: 1, b: 2, c: 3, d: 4 } }
    let(:except_keys) { %I[b d] }
    let(:hash_except_keys) { { a: 1, c: 3 } }

    it 'does return' do
      expect(subject.hash_except_keys(hash, keys: except_keys))
        .to eq(hash_except_keys)
    end
  end

  describe '.constantize' do
    context 'class exists' do
      let(:klass_name) { 'Industry::Partial::Default' }
      let(:klass) { Industry::Partial::Default }

      it 'does return' do
        expect(subject.constantize(klass_name)).to eq(klass)
      end
    end

    context 'class doesn\'t exist' do
      let(:klass_name) { 'Industry::Partial::Hjhjhjhj' }

      it 'does return' do
        expect { subject.constantize(klass_name) }.to raise_error NameError
      end
    end
  end
end
