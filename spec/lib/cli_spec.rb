# frozen_string_literal: true

require 'cli'

shared_examples 'Cli test' do |description, args|
  subject(:cli_object) { described_class.new(args) }

  it description do
    expect do
      cli_object.call
    end.to output("#{expectation}\n").to_stdout
  end
end

describe Cli do
  describe '#call' do
    context 'when no arguments provided' do
      let(:expectation) do
        'Please provide a file location to get the webserver log report.'
      end

      include_examples 'Cli test', 'prompts about missing filepath', []
    end

    context 'when invalid filepath is provided' do
      let(:expectation) do
        'Could not open the file abc. Please verify the file location.'
      end

      before { allow(File).to receive(:open).and_raise(Errno::ENOENT) }

      include_examples 'Cli test', 'prompts about invalid filepath', %w[abc]
    end

    context 'when valid filepath is provided' do
      let(:file_content) { 'foo' }
      let(:expectation) { file_content }
      let(:file) { instance_double(File, read: file_content) }

      before do
        allow(File).to receive(:open).and_return(file)
      end

      include_examples 'Cli test', 'reads the file', ['filepath']
    end
  end
end
