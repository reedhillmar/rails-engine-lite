# frozen_string_literal: true

# app/models/item.rb
class Item < ApplicationRecord
  belongs_to :merchant
end
