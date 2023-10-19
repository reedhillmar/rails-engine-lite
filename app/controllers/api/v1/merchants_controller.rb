# frozen_string_literal: true

# app/controllers/api/v1/merchants_controller.rb
class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def find
    if !params[:name] || params[:name] == ''
      head 400
    else
      search = Merchant.search(params[:name])

      if !search
        render json: { data: {} }
      else
        render json: MerchantSerializer.new(Merchant.find(search))
      end
    end
  end
end
