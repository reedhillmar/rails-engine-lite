# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { Faker::Beer.name }
    description { Faker::Beer.style }
    unit_price { Faker::Number.decimal(l_digits: 2) }
  end
end
