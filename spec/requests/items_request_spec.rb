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

    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(Integer)

      expect(item).to have_key(:name)
      expect(item[:name]).to be_a(String)

      expect(item).to have_key(:description)
      expect(item[:description]).to be_a(String)

      expect(item).to have_key(:unit_price)
      expect(item[:unit_price]).to be_a(Float)

      expect(item).to have_key(:merchant_id)
      expect(item[:merchant_id]).to be_an(Integer)
      expect(item[:merchant_id]).to eq(id)
    end
  end

  it 'returns a single item by item id' do
    merch_id = create(:merchant).id

    id = create(:item, merchant_id: merch_id).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(item).to have_key(:id)
    expect(item[:id]).to eq(id)

    expect(item).to have_key(:name)
    expect(item[:name]).to be_a(String)

    expect(item).to have_key(:description)
    expect(item[:description]).to be_a(String)

    expect(item).to have_key(:unit_price)
    expect(item[:unit_price]).to be_a(Float)

    expect(item).to have_key(:merchant_id)
    expect(item[:merchant_id]).to eq(merch_id)
  end

  it 'can create a new item' do
    merch_id = create(:merchant).id

    item_params = { name: 'La Folie',
                    description: 'Dark Sour Ale',
                    unit_price: 8.76 }

    headers = {'CONTENT_TYPE' => 'application/json'}

    post "/api/v1/merchants/#{merch_id}/items", headers: headers, params: JSON.generate(item: item_params)

    created_item = Item.last

    expect(response).to be_successful
    expect(create_item.name).to eq(item_params[:name])
    expect(create_item.description).to eq(item_params[:description])
    expect(create_item.unit_price).to eq(item_params[:unit_price])
    expect(create_item.merchant_id).to eq(merch_id)
  end
end

# rubocop:enable Metrics/BlockLength
