$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "json_routes/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "json_routes"
  s.version     = JsonRoutes::VERSION
  s.authors     = ["ariannasavant"]
  s.email       = ["arianna@cometa.consulting"]
  s.homepage    = ""
  s.summary     = "JsonRoutes translates the parent application's roues into a resource-nested JSON object."
  s.description = "JsonRoutes takes the routes of the parent application and organizes them into a JSON object, nested by resource.  It then provides routes in which that JSON can be easily accessed and parsed by a front-end client.  JsonRoutes was built to provid front-end clients with a way to access routes using names, rather than hard-coding URLs into their platform."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.2"

  s.add_development_dependency "sqlite3"
end
