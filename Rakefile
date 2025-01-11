# Rakefile

require 'rake'
require 'graphql/client'
require 'graphql/client/http'

namespace :schema do
  desc "Download the GraphQL schema"
  task :download do
    http = GraphQL::Client::HTTP.new(ENV["SPREADSHOP_GRAPH_CLIENT_URL"])
    schema = GraphQL::Client.load_schema(http)
    File.open("lib/spreadshop_graph_client/schema.json", "w") do |file|
      file.write(schema.to_json)
    end
    puts "Schema downloaded successfully to lib/spreadshop_graph_client/schema.json"
  end
end
