require "graphql/client"
require "graphql/client/http"

module SpreadshopGraphClient
  class Client
    # Configuration attributes with defaults
    @api_url = ENV["SPREADSHOP_GRAPH_CLIENT_URL"] || "https://api.spreadshop.com/v1/graphql"

    class << self
      attr_accessor :api_url
    end

    # Provide a configure method to allow users to set api_url and api_token
    def self.configure
      yield self
    end

    # Lazy initialization of HTTP adapter
    def self.http
      @http ||= GraphQL::Client::HTTP.new(api_url) do
        def headers(context)
          {
            "User-Agent" => "My Client"
          }
        end
      end
    end

    # Load schema from local file in test environment, else fetch from HTTP
    def self.schema
      @schema ||= if ENV['RACK_ENV'] == 'test'
                   schema_path = File.join(__dir__, 'schema.json')
                   GraphQL::Client.load_schema(schema_path)
                 else
                   GraphQL::Client.load_schema(http)
                 end
    end

    # Lazy creation of the GraphQL client
    def self.graphql_client
      @graphql_client ||= GraphQL::Client.new(schema: schema, execute: http)
    end

    # Parse method using the lazy GraphQL client
    def self.parse(query_str)
      graphql_client.parse(query_str)
    end

    # Query method using the lazy GraphQL client
    def self.query(document, variables: {})
      response = graphql_client.query(document, variables: variables)
      if response.errors.any?
        raise "GraphQL Errors: #{response.errors.full_messages.join(', ')}"
      end
      response.data
    end
  end
end
