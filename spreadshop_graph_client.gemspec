$:.push File.expand_path("../lib", __FILE__)
require "spreadshop_graph_client/version"

Gem::Specification.new do |s|
  s.name        = "spreadshop_graph_client"
  s.version     = SpreadshopGraphClient::VERSION
  s.required_ruby_version = ">= 3.0"
  s.summary     = "Spreadshop graphql client"
  s.description = "This gem allows you to easily use the spreadshop graphql interface"
  s.authors     = ["-"]
  s.email       = "-"
  s.files       = Dir["lib/**/*"]
  s.homepage    =
    "-"
  s.license       = "MIT"


  s.add_dependency "graphql-client", "~> 0.17"
end