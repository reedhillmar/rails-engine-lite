# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'rails_helper'

describe 'Items API' do
  it 'returns a list of all items' do
    id = create(:merchant).id

    create_list(:item, 3, merchant_id: id)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(3)

    items[:data].each do |item|
      # require 'pry';binding.pry
      expect(item).to have_key(:id)
      expect(item[:id].to_i).to be_an(Integer)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id].to_i).to be_an(Integer)
      expect(item[:attributes][:merchant_id].to_i).to eq(id)
    end
  end

  it 'returns a single item by item id' do
    merch_id = create(:merchant).id

    id = create(:item, merchant_id: merch_id).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id].to_i).to eq(id)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price].to_f).to be_a(Float)

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id].to_i).to eq(merch_id)
  end

  it 'can create a new item' do
    merch_id = create(:merchant).id

    item_params = { name: 'La Folie',
                    description: 'Dark Sour Ale',
                    unit_price: 8.76 }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post "/api/v1/merchants/#{merch_id}/items", headers:, params: JSON.generate(item: item_params)

    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(merch_id)
  end

  it 'can edit an item' do
    merch_id = create(:merchant).id
    item_id = create(:item, merchant_id: merch_id).id
    previous_price = Item.last.unit_price
    item_params = { unit_price: 3.08 }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    patch "/api/v1/merchants/#{merch_id}/items/#{item_id}", headers:, params: JSON.generate(item: item_params)
    item = Item.find_by(id: item_id)

    expect(response).to be_successful
    expect(item.unit_price).to_not eq(previous_price)
    expect(item.unit_price).to eq(3.08)
  end

  it 'can delete an item' do
    merch_id = create(:merchant).id
    item_id = create(:item, merchant_id: merch_id).id

    expect(Item.count).to eq(1)

    delete "/api/v1/merchants/#{merch_id}/items/#{item_id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect { Item.find(item_id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end

# rubocop:enable Metrics/BlockLength
