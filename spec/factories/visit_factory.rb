# frozen_string_literal: true

FactoryBot.define do
  factory :visit do
    # Sequel model save! method is not defined
    to_create(&:save)

    path { 'a' }
    visitor_identifier { '1' }
  end
end
