# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe '.search' do
    it "can return a merchant's id by keyword" do
      create_list(:merchant, 3)
      aaron_id = create(:merchant, name: "Aaron's Amazing Ales").id

      expect(Merchant.search('zing')).to eq(aaron_id)
    end
  end
end
