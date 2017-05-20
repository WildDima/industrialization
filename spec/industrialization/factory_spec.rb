require 'spec_helper'

RSpec.describe Industrialization::Factory do
  let(:obj) { double('obj') }
  let(:path) { 'spec/factories' }
  subject { described_class.new(obj: obj, path: path) }

  context 'file already present' do
    it 'does return error message' do
      expect_any_instance_of(Industrialization::File)
        .to receive(:create).and_call_original

      expect_any_instance_of(Industrialization::File)
        .to receive(:created?).and_call_original

      expect(subject.call).to eq('ERROR')
    end
  end
end
