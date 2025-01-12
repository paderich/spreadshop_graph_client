require_relative "../client"

module SpreadshopGraphClient
  module Queries
    class ShopQuery    
      QUERY = <<~GRAPHQL
        query($name: String!, $platform: Platform!, $locale: Locale!) {
          shop(name: $name, platform: $platform, locale: $locale) {
            id
            name
          }
        }
      GRAPHQL

      DOCUMENT = SpreadshopGraphClient::Client.parse(QUERY)

      def self.call(name:, platform:, locale:)
        response = Client.query(DOCUMENT, variables: { name: name, platform: platform, locale: locale })
        response.shop
      end

      class Shop
        attr_accessor :id, :name

        def initialize(id:, name:)
          @id = id
          @name = name
        end
      end
    end
  end
end
