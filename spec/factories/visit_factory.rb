FactoryBot.define do
  factory :visit do
    # Sequel model save! method is not defined
    to_create { |i| i.save }

    path { 'a' }
    visitor_identifier { '1' }
  end
end
