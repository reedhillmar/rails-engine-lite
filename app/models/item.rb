# frozen_string_literal: true

# app/models/item.rb
class Item < ApplicationRecord
  belongs_to :merchant

  def self.name_search(keyword)
    where('name iLIKE ?', "%#{keyword}%").order_by_name
  end

  def self.price_range_search(min, max)
    where("unit_price BETWEEN ? and ?", min, max).order_by_name
  end

  def self.min_price_search(min)
    where("unit_price >= #{min}").order_by_name
  end

  def self.max_price_search(max)
    where("unit_price <= #{max}").order_by_name
  end

  def self.order_by_name
    order('LOWER(name)')
  end
end
