class Apify
  
  def update_route_json
    load Rails.application.root.join('config/routes.rb') 
    save_to_file(get_resources)
  end
  
  private

    def get_resources
      routes = []
      previous_normalised_route = nil

      Rails.application.routes.routes.each_with_index do |route, i|
        next if route.app.is_a?(ActionDispatch::Routing::Mapper::Constraints)
        normalised_route = normalise_route(route, previous_normalised_route)[0] 
        routes << normalised_route
        previous_normalised_route = normalised_route
      end

      grouped_routes(routes.compact)
    end
  
    def normalise_route(route, previous_normalised_route, path_prefix = nil)
      route.verb.source.split('|').map do |verb, i|
        # fixme this is a really hackish and error prone way to assign names
        # to nameless PATCH PUT DELETE endpoints, built on the assumptions that
        # these verb routes will follow the GET verb - look for a better solution
        route_name = route.name.nil? ? previous_normalised_route[:name] : route.name

        {
          :name => route_name,
          :verb => verb.gsub(/[$^]/, ''),
          :uri_pattern => path_prefix.to_s + route.path.spec.to_s.sub('(.:format)', ''),
          :resource_name => route.requirements[:controller]
        }
      end
    end
     
    def grouped_routes(routes)
      grouped_routes = routes
                      .group_by { |r| r[:resource_name] }
                      .select { |resource_name| ! resource_name.start_with?('rails') }

      grouped_routes.each do |resource_name, resource_endpoints|
        resource_endpoints.map do |r|
          r.delete(:resource_name)
          r
        end
      end

      grouped_routes
    end

    def save_to_file(doc)
      output_file = File.open('apify_resources.json', 'w') 
      output_file << doc.to_json
      output_file.close
    end
end