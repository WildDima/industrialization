require 'spec_helper'

RSpec.describe Industrialization::Factory do
  let(:obj) { 1 }
  let(:path) { 'spec/factories' }
  let(:error_messages) { 'File already exists' }
  subject { described_class.new(obj: obj, path: path) }

  context 'file already present' do
    it 'does return error message' do
      allow_any_instance_of(Industrialization::File).to receive(:create) do |value|
        value.errors << error_messages
        value
      end

      expect_any_instance_of(Industrialization::File).to receive(:create)

      expect_any_instance_of(Industrialization::File).to receive(:created?).and_call_original

      expect(subject.call).to eq(error_messages)
    end
  end
end
