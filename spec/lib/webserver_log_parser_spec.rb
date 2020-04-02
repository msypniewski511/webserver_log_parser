# frozen_string_literal: true

describe WebserverLogParser do
  describe '#call' do
    subject(:object) { described_class.new(file) }

    let(:file_path) { File.expand_path('../fixtures/single.log', __dir__) }
    let(:file) { File.open(file_path, 'r') }
    let(:expectation) { "/help_page/1 126.318.035.038\n" }

    it 'reads the file' do
      expect { object.call }.to output(expectation).to_stdout
    end
  end
end
