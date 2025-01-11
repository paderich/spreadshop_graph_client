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
    "https://ruby-gems.org"
  s.license       = "MIT"


  s.add_dependency "graphql-client", "~> 0.17"

  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "webmock", "~> 3.0"
  s.add_development_dependency "vcr", "~> 6.0"
  s.add_development_dependency "dotenv"
  s.add_development_dependency 'rake', '~> 13.0'
end