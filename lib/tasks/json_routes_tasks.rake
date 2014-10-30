desc "Populate document with updated route tree as JSON"
task :json_routes do
  require_relative '../apify.rb'
  Apify.new.update_route_json
  puts "'apify_resources.json' was successfully written to"
end
