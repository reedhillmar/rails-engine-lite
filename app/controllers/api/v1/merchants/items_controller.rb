# frozen_string_literal: true

module Api
  module V1
    # app/controllers/api/v1/items_controller
    class Merchants::ItemsController < ApplicationController
      def index
        render json: ItemSerializer.new(Item.where(merchant_id: params[:merchant_id]))
      end

      def show
        render json: ItemSerializer.new(Item.find(params[:id]))
      end

      def create
        render json: Merchant.find(params[:merchant_id]).items.create(item_params)
      end

      def update
        render json: Item.update(params[:id], item_params)
      end

      def destroy
        render json: Item.delete(params[:id])
      end

      private

      def item_params
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
      end
    end
  end
end
