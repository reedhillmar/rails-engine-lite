# frozen_string_literal: true

class Api::V1::Items::MerchantsController < ApplicationController
  def show
    merch_id = Item.find(params[:id])[:merchant_id]
    render json: MerchantSerializer.new(Merchant.find(merch_id))
  end
end
