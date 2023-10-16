# frozen_string_literl: true

class Api::V1::ItemsController < ApplicationController
  def index
    render json: Item.all
  end
end
