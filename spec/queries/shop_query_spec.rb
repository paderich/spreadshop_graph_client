# spec/shop_query_spec.rb

require 'spec_helper'                                 # Load spec_helper first
require 'spreadshop_graph_client/queries/shop_query' # Then require your gem's query file

RSpec.describe SpreadshopGraphClient::Queries::ShopQuery do
  describe '.call', :vcr do
    context 'with valid parameters' do
      it 'returns the correct shop data' do
        shop = SpreadshopGraphClient::Queries::ShopQuery.call(
          name: "code-quest",
          platform: "EU",
          locale: "de_DE"
        )
        puts shop.inspect
        expect(shop).not_to be_nil
        expect(shop.id).to eq("1394271")
        expect(shop.name).to eq("code-quest")
      end
    end

    context 'with invalid parameters' do
      it 'raises an error when GraphQL returns errors' do
        expect {
          SpreadshopGraphClient::Queries::ShopQuery.call(
            name: "",                  # Invalid name
            platform: "INVALID",       # Invalid platform
            locale: "invalid_locale"   # Invalid locale
          )
        }.to raise_error(NoMethodError)
      end
    end
  end
end
