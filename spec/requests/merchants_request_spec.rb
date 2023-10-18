# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of all merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(3)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id].to_i).to be_an(Integer)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'can return a merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id].to_i).to eq(id)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it "can return all of a merchant's items" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    create_list(:item, 4, merchant_id: merchant1.id)
    
    first = Item.first
    second = Item.second
    third = Item.third
    last = Item.last

    create_list(:item, 8, merchant_id: merchant2.id)
    
    get "/api/v1/merchants/#{merchant1.id}/items"

    expect(response).to be_successful
    expect(merchant1.items.count).to eq(4)
    expect(merchant1.items.first).to eq(first)
    expect(merchant1.items.second).to eq(second)
    expect(merchant1.items.third).to eq(third)
    expect(merchant1.items.last).to eq(last)
  end
end

# rubocop:enable Metrics/BlockLength
