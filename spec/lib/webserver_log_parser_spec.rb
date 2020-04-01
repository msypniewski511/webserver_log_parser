# frozen_string_literal: true

describe WebserverLogParser do
  describe '#call' do
    subject { described_class.new('hi').call }

    it { is_expected.to eq('hi') }
  end
end
