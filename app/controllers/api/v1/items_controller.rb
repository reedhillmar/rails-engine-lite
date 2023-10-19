# frozen_string_literal: true

# app/controllers/api/v1/items_controller.rb
class Api::V1::ItemsController < ApplicationController
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
      response.body = ItemSerializer.new(item).to_json
    else
      head 400
    end
  end

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

  def find_all
    if check_validity
      render json: { errors: ["Your shit's fucked!"] }, status: 400
    else
      render_search(select_search)
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

  def check_validity
    no_params_check || too_many_params_check || empty_name_check || min_price_check || max_price_check
  end

  def no_params_check
    !params[:name] && !params[:min_price] && !params[:max_price]
  end

  def too_many_params_check
    params[:name] && (params[:min_price] || params[:max_price])
  end

  def empty_name_check
    params[:name] && params[:name] == ''
  end

  def min_price_check
    params[:min_price] && (params[:min_price] == '' || params[:min_price].to_f.negative?)
  end

  def max_price_check
    params[:max_price] && (params[:max_price] == '' || params[:max_price].to_f.negative?)
  end

  def render_search(search)
    if !search
      render json: { data: [] }
    else
      render json: ItemSerializer.new(search)
    end
  end

  def select_search
    if params[:name]
      Item.name_search(params[:name])
    elsif params[:min_price] && params[:max_price]
      Item.price_range_search(min, max)
    elsif params[:min_price]
      Item.min_price_search(min)
    else
      Item.max_price_search(max)
    end
  end

  def min
    price_to_float(params[:min_price])
  end

  def max
    price_to_float(params[:max_price])
  end

  def price_to_float(string)
    string&.to_f
  end
end
