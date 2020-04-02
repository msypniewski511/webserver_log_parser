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
end
