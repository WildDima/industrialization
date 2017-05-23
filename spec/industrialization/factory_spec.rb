require 'spec_helper'

RSpec.describe Industrialization::Factory do
  let(:object_attributes) { { a1: 1, a2: '12', a3: nil, a4: {} } }
  let(:object) { double('TestObject', object_attributes) }
  let(:file) { double('File') }
  let(:path) { 'spec/factories' }
  let(:error_messages) { 'File already exists' }
  let(:success_message) { 'factory spec/factories/rspec_mocks_double.rb was created' }
  subject { described_class.new(obj: object, factories_path: path) }

  before do
    allow(object).to receive(:serializable_hash) { object_attributes }
  end

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

  context 'file doesn\'t present' do
    it 'return success message' do
      allow(::File).to receive(:exist?).and_return(true)

      allow_any_instance_of(Industrialization::File).to receive(:create) do |value|
        value.created = true
        value.file = file
        value
      end

      allow(file).to receive(:write)

      expect_any_instance_of(Industrialization::File).to receive(:create)

      expect_any_instance_of(Industrialization::File).to receive(:created?).and_call_original

      expect(subject.call).to eq(success_message)
    end
  end
end
