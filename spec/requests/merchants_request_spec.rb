# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of all merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(Integer)

      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to be_a(String)
    end
  end

  it 'can return a merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to eq(id)

    expect(merchant).to have_key(:name)
    expect(merchant[:name]).to be_a(String)
  end

  it "can return all of a merchant's items" do
    merchant = create(:merchant)

    create_list(:item, 4, merchant_id: merchant.id)

    first = Item.first
    second = Item.second
    third = Item.third
    last = Item.last

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful
    expect(merchant.items.count).to eq(4)
    expect(merchant.items.first).to eq(first)
    expect(merchant.items.second).to eq(second)
    expect(merchant.items.third).to eq(third)
    expect(merchant.items.last).to eq(last)
  end
end

# rubocop:enable Metrics/BlockLength
