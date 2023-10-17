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

      def create
        item = Item.create(item_params)
        if item.save
          head 201
        else
          head 400
        end
        response.body = ItemSerializer.new(item).to_json
      end

      # refactor me!!!
      def update
        if Item.find(params[:id]) && (!params[:merchant_id] || Merchant.find(params[:merchant_id]))
          render json: ItemSerializer.new(Item.update(params[:id], item_params))
        else
          head 404
        end
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
