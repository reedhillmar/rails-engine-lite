# frozen_string_literal: true

module Api
  module V1
    module Merchants
      # app/controllers/api/v1/items_controller
      class ItemsController < ApplicationController
        def index
          render json: ItemSerializer.new(Item.where(merchant_id: params[:merchant_id])) if
            Merchant.find(params[:merchant_id])
        rescue ActiveRecord::RecordNotFound
          render json: { message: 'you have fucked up', errors: "Your shit's fucked!" }, status: 404
        end
      end
    end
  end
end
