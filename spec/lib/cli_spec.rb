# frozen_string_literal: true

require 'cli'

require_relative '../shared_examples/output_spec'

describe Cli do
  describe '#call' do
    subject(:object) { described_class.new(args) }

    context 'when no arguments provided' do
      let(:expectation) do
        "Please provide a file location to get the webserver log report.\n"
      end
      let(:args) { [] }

      include_examples 'Output test', 'prompts about missing filepath'
    end

    context 'when invalid filepath is provided' do
      let(:expectation) do
        "Could not open the file abc. Please verify the file location.\n"
      end
      let(:args) { %w[abc] }

      before { allow(File).to receive(:open).and_raise(Errno::ENOENT) }

      include_examples 'Output test', 'prompts about invalid filepath'
    end

    context 'when valid filepath is provided' do
      let(:file_content) { 'foo 123' }
      let(:expectation) { "foo 1\n\nfoo 1\n\n" }
      let(:file) { instance_double(File) }
      let(:args) { ['filepath'] }

      before do
        allow(file).to receive(:each_line).and_yield(file_content)
        allow(File).to receive(:open).and_return(file)
      end

      include_examples 'Output test', 'reads the file'
    end
  end
end
