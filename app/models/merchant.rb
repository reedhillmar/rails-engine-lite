# frozen_string_literal: true

# app/models/merchant.rb
class Merchant < ApplicationRecord
  has_many :items
end
