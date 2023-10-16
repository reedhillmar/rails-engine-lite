# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { Faker::Beer.name }
    description { Faker::Beer.style }
    unit_price { Faker::Number.within(range: 3.00..10.00) }
  end
end
