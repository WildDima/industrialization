require 'spec_helper'

RSpec.describe Industry::File do
  let(:path) { 'test_path/for' }
  let(:name) { 'file.rb' }
  let(:file) { described_class.new(path: path, name: name) }
  let(:data) { 'test data' }
  let(:full_path) { "#{path}/#{name}" }

  context 'file already exists' do
    before do
      allow(::File).to receive(:exist?).with(full_path).and_return(true)
    end

    describe '#create' do
      let(:error_messages) { 'File already exists' }
      subject { file.create }

      it 'does return errors' do
        expect(subject.errors).not_to be_empty
      end
      it do
        expect(subject.error_messages).to eq error_messages
      end
    end

    describe '#error_messages' do
      let(:error_messages) { 'File already exists' }
      let(:errors) { ['File already exists'] }

      before do
        file.errors = errors
      end

      it 'does return errors message' do
        expect(file.error_messages).to eq(error_messages)
      end
    end

    describe '#created?' do
      it 'doesn\'t create file' do
        expect(file.created?).to be_falsy
      end
    end

    describe '#write' do
      it 'doesn\'t write file' do
        expect { file.write(data) }.to raise_error(NoMethodError)
      end
    end
  end

  context 'file doesn\'t exists' do
    let(:opened_file) { double('file') }
    let(:mode) { 'w+' }
    let(:file) { described_class.new(path: path, name: name) }

    before do
      allow(::File).to receive(:exist?).with(full_path).and_return(false)
      allow(::File).to receive(:open).with(full_path, mode).and_return(opened_file)
      allow(opened_file).to receive(:write).with(data)
    end

    describe '#create' do
      it 'does create file' do
        expect { file.create }.to change { file.created? }.from(false).to(true)
      end
    end

    describe '#write' do
      it 'does write in file, if file was created' do
        expect(file.create.write(data)).to eq(file)
      end
    end
  end
end
