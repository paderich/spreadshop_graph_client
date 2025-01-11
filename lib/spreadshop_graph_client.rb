
require_relative "spreadshop_graph_client/client"

require_relative "spreadshop_graph_client/queries/shop_query"
require_relative "spreadshop_graph_client/queries/products_query"

module SpreadshopGraphClient

  def self.fetch_shop(name:, platform:, locale:)
    Queries::ShopQuery.call(name: name, platform: platform, locale: locale)
  end

  def self.fetch_products(shopId:, platform:, locale:)
    Queries::ProductsQuery.call(shopId: shopId, platform: platform, locale: locale)
  end

end
