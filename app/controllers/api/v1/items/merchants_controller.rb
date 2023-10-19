# frozen_string_literal: true

module Api
  module V1
    module Items
      # app/controllers/api/v1/items/merchants_controller.rb
      class MerchantsController < ApplicationController
        def show
          merch_id = Item.find(params[:id])[:merchant_id]
          render json: MerchantSerializer.new(Merchant.find(merch_id))
        end
      end
    end
  end
end
