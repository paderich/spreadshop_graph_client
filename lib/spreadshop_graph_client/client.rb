require "graphql/client"
require "graphql/client/http"

module SpreadshopGraphClient
  class Client
    @api_url = ENV["SPREADSHOP_GRAPH_CLIENT_URL"] || "https://api.spreadshop.com/v1/graphql"

    class << self
      attr_accessor :api_url
    end

    def self.configure
      yield self
    end

    def self.http
      @http ||= GraphQL::Client::HTTP.new(api_url) do
        def headers(context)
          {
            "User-Agent" => "My Client"
          }
        end
      end
    end

    def self.schema
      @schema ||= if ENV['RACK_ENV'] == 'test'
                   schema_path = File.join(__dir__, 'schema.json')
                   GraphQL::Client.load_schema(schema_path)
                 else
                   GraphQL::Client.load_schema(http)
                 end
    end

    def self.graphql_client
      @graphql_client ||= GraphQL::Client.new(schema: schema, execute: http)
    end

    def self.parse(query_str)
      graphql_client.parse(query_str)
    end

    def self.query(document, variables: {})
      response = graphql_client.query(document, variables: variables)
      if response.errors.any?
        raise "GraphQL Errors: #{response.errors.full_messages.join(', ')}"
      end
      response.data
    end
  end
end
