# frozen_string_literal: true

require 'visit'
require 'fetch_and_print_data'

require_relative '../shared_examples/output_spec'

describe FetchAndPrintData do
  describe '#call' do
    subject(:object) { described_class.new(model_klass, invalid_entries) }

    let(:model_klass) { Visit }
    let(:entries) { [{ path: 'foo', count: '2' }] }

    context 'when there are no records' do
      let(:invalid_entries) { [] }
      let(:expectation) { '' }

      include_examples 'Output test', 'prints nothing'
    end

    context 'when there are data to display' do
      let(:invalid_entries) { [%w[foo error]] }
      let(:expectation) do
        %(foo 2\n\nfoo 2\n\nError: 'foo' in line: 'error'\n\n)
      end

      before do
        %i[group_by_path_with_count unique_visits].each do |method|
          allow(model_klass).to receive(method).and_return(entries)
        end
      end

      include_examples 'Output test', 'prints data'
    end
  end
end
