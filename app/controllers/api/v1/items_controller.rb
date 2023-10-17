# frozen_string_literal: true

module Api
  module V1
    # app/controllers/api/v1/items_controller
    class ItemsController < ApplicationController
      def index
        render json: Item.all
      end

      def show
        render json: Item.find(params[:id])
      end

      def create
        render json: Merchant.find(params[:merchant_id]).items.create(item_params)
      end

      def update
        render json: Merchant.find(params[:merchant_id]).items.update(params[:id], item_params)
      end

      private

      def item_params
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
      end
    end
  end
end
