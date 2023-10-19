# frozen_string_literal: true

# app/models/merchant.rb
class Merchant < ApplicationRecord
  has_many :items

  def self.search(keyword)
    order(:name).where("name iLIKE ?", "%#{keyword}%").first&.id
  end
end
