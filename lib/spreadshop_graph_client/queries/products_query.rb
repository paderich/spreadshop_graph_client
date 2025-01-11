require_relative "../client"

module SpreadshopGraphClient
  module Queries
    module ProductsQuery
      QueryDocument = Client.parse <<~GRAPHQL
        query($shopId: ID!, $platform: Platform!, $locale: Locale!) {
          products(shopId: $shopId, platform: $platform, locale: $locale) {
            items {
              id
              name
              image {
                src
                srcset
                altText
                format
              }
              price {
                vatExcluded
                vatIncluded
                vatAmount
              }
            }
          }
        }
      GRAPHQL

      # def self.call(shopId:, platform:, locale:)
      #   response = Client.query(
      #     QueryDocument,
      #     variables: { shopId: shopId, platform: platform, locale: locale }
      #   )
      #   raise "GraphQL Errors: #{response.errors.inspect}" if response.errors.any?
      #   response.data.products
      # end
      def self.call(shopId:, platform:, locale:)
        document = Client.parse(QUERY)
        response = Client.query(document, variables: { shopId: shopId, platform: platform, locale: locale})
        response.products
      end
    
    end
  end
end
