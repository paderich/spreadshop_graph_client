require_relative "../client"

module SpreadshopGraphClient
  module Queries
    module ShopQuery
      QueryDocument = Client.parse <<~GRAPHQL
        query($name: String!, $platform: Platform!, $locale: Locale!) {
          shop(name: $name, platform: $platform, locale: $locale) {
            id
            name
          }
        }
      GRAPHQL

      def self.call(name:, platform:, locale:)
        response = Client.query(
          QueryDocument,
          variables: { name: name, platform: platform, locale: locale }
        )
        raise "GraphQL Errors: #{response.errors.inspect}" if response.errors.any?
        response.data.shop
      end
    end
  end
end
