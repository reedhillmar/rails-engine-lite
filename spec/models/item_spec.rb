# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it { should belong_to(:merchant) }
  end

  describe 'class methods' do
    describe '.name_search' do
      it 'can return an all items by name' do
        merchant_id = create(:merchant).id

        ipa1 = create(:item, name: 'Hoppy IPA', merchant_id:)
        ipa2 = create(:item, name: 'Hoppier IPA', merchant_id:)
        ipa3 = create(:item, name: 'Hoppiest IPA', merchant_id:)
        sour = create(:item, name: "I'm a sour", merchant_id:)
        create(:item, name: "I'm a pilsner", merchant_id:)
        create(:item, name: "I'm a porter", merchant_id:)

        results = Item.name_search('ipa')

        expect(results.length).to eq(3)
        expect(results).to include(ipa1)
        expect(results).to include(ipa2)
        expect(results).to include(ipa3)
        expect(results).to_not include(sour)
      end
    end

    describe '.price_range_search' do
      it 'can return prices within a range' do
        merchant_id = create(:merchant).id

        ipa1 = create(:item, name: 'Hoppy IPA', unit_price: 5, merchant_id:)
        ipa2 = create(:item, name: 'Hoppier IPA', unit_price: 10, merchant_id:)
        ipa3 = create(:item, name: 'Hoppiest IPA', unit_price: 15, merchant_id:)
        sour = create(:item, name: "I'm a sour", unit_price: 20, merchant_id:)
        pils = create(:item, name: "I'm a pilsner", unit_price: 25, merchant_id:)

        results = Item.price_range_search(10, 20)

        expect(results.length).to eq(3)
        expect(results).to_not include(ipa1)
        expect(results).to include(ipa2)
        expect(results).to include(ipa3)
        expect(results).to include(sour)
        expect(results).to_not include(pils)
      end
    end

    describe '.min_price_search' do
      it 'can return prices over a given value' do
        merchant_id = create(:merchant).id

        ipa1 = create(:item, name: 'Hoppy IPA', unit_price: 5, merchant_id:)
        ipa2 = create(:item, name: 'Hoppier IPA', unit_price: 10, merchant_id:)
        ipa3 = create(:item, name: 'Hoppiest IPA', unit_price: 15, merchant_id:)
        sour = create(:item, name: "I'm a sour", unit_price: 20, merchant_id:)
        pils = create(:item, name: "I'm a pilsner", unit_price: 25, merchant_id:)

        results = Item.min_price_search(15)

        expect(results.length).to eq(3)
        expect(results).to_not include(ipa1)
        expect(results).to_not include(ipa2)
        expect(results).to include(ipa3)
        expect(results).to include(sour)
        expect(results).to include(pils)
      end
    end

    describe '.max_price_search' do
      it 'can return prices over a given value' do
        merchant_id = create(:merchant).id

        ipa1 = create(:item, name: 'Hoppy IPA', unit_price: 5, merchant_id:)
        ipa2 = create(:item, name: 'Hoppier IPA', unit_price: 10, merchant_id:)
        ipa3 = create(:item, name: 'Hoppiest IPA', unit_price: 15, merchant_id:)
        sour = create(:item, name: "I'm a sour", unit_price: 20, merchant_id:)
        pils = create(:item, name: "I'm a pilsner", unit_price: 25, merchant_id:)

        results = Item.max_price_search(15)

        expect(results.length).to eq(3)
        expect(results).to include(ipa1)
        expect(results).to include(ipa2)
        expect(results).to include(ipa3)
        expect(results).to_not include(sour)
        expect(results).to_not include(pils)
      end
    end

    describe '.order_by_name' do
      it 'can return items alphabetically by name' do
        merchant_id = create(:merchant).id

        ipa1 = create(:item, name: 'Hoppy IPA', unit_price: 5, merchant_id:)
        ipa2 = create(:item, name: 'hoppier IPA', unit_price: 10, merchant_id:)
        ipa3 = create(:item, name: 'Hoppiest IPA', unit_price: 15, merchant_id:)
        sour = create(:item, name: "i'm a sour", unit_price: 20, merchant_id:)
        pils = create(:item, name: "I'm a pilsner", unit_price: 25, merchant_id:)

        results = Item.order_by_name

        expect(results).to eq([ipa2, ipa3, ipa1, pils, sour])
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
