# frozen_string_literal: true

shared_examples 'Parser test' do |description|
  it description do
    expect do
      system(command)
    end.to output("#{expectation}\n").to_stdout_from_any_process
  end
end

describe 'parser' do
  context 'when no arguments provided' do
    let(:expectation) do
      'Please provide a file location to get the webserver log report.'
    end
    let(:command) { 'ruby parser.rb' }

    include_examples 'Parser test', 'prompts about missing filepath'
  end

  context 'when invalid filepath is provided' do
    let(:expectation) do
      'Could not open the file abc. Please verify the file location.'
    end
    let(:command) { 'ruby parser.rb abc' }

    include_examples 'Parser test', 'returns information about invalid filepath'
  end

  context 'when valid filepath is provided' do
    let(:expectation) { '/help_page/1, 126.318.035.038' }
    let(:file_path) { File.expand_path('../fixtures/single.log', __dir__) }
    let(:command) { "ruby parser.rb #{file_path}" }

    include_examples 'Parser test', 'reads the file'
  end
end
