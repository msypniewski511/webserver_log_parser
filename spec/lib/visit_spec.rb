# frozen_string_literal: true

require 'visit'

describe Visit do
  subject(:visit) do
    described_class.new(path: '/help_page/1',
                        visitor_identifier: '126.318.035.038')
  end

  describe '#valid?' do
    it 'is valid with valid attributes' do
      expect(visit).to be_valid
    end

    it 'is not valid without a path' do
      visit.path = nil
      expect(visit).not_to be_valid
    end

    it 'is not valid without a visitor_identifier' do
      visit.visitor_identifier = nil
      expect(visit).not_to be_valid
    end
  end

  describe '.group_by_path_with_count' do
    subject(:query) do
      described_class.group_by_path_with_count.map(&:values)
    end

    context 'with data' do
      let(:expectation) { [{ count: 3, path: 'b' }, { count: 2, path: 'a' }] }

      before { given_entries }

      it { is_expected.to eq(expectation) }
    end

    context 'without data' do
      it { is_expected.to eq([]) }
    end
  end

  describe '.unique_visits' do
    subject(:query) do
      described_class.unique_visits.map(&:values)
    end

    context 'with data' do
      let(:expectation) { [{ count: 2, path: 'a' }, { count: 1, path: 'b' }] }

      before { given_entries }

      it { is_expected.to eq(expectation) }
    end

    context 'without data' do
      it { is_expected.to eq([]) }
    end
  end

  private

  def given_entries
    create(:visit, path: 'a', visitor_identifier: '1')
    create(:visit, path: 'a', visitor_identifier: '2')
    create(:visit, path: 'b', visitor_identifier: '3')
    create(:visit, path: 'b', visitor_identifier: '3')
    create(:visit, path: 'b', visitor_identifier: '3')
  end
end
