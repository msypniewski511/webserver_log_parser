# frozen_string_literal: true

require 'parse_and_store_data'

describe ParseAndStoreData do
  describe '#call' do
    subject(:object) { described_class.new(file_handle) }

    let(:file_handle) { File.open(file_path, 'r') }

    context 'when file containt valid data' do
      let(:file_path) { File.expand_path('../fixtures/single.log', __dir__) }
      let(:expectation) { ['/help_page/1', '126.318.035.038'] }

      it 'stores data' do
        object.call
        expect(Visit.get(Visit::ATTRS)).to eq(expectation)
      end
    end

    context 'when file containt invalid data' do
      let(:file_path) do
        File.expand_path('../fixtures/invalid.log', __dir__)
      end

      it 'does not store anything' do
        object.call
        expect(Visit.count).to be_zero
      end
    end
  end
end
