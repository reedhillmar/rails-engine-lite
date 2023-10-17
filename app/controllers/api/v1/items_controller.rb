# frozen_string_literal: true

module Api
  module V1
    # app/controllers/api/v1/items_controller
    class ItemsController < ApplicationController
      def index
        render json: ItemSerializer.new(Item.all)
      end

      def show
        render json: ItemSerializer.new(Item.find(params[:id]))
      end

      private

      def item_params
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
      end
    end
  end
end
