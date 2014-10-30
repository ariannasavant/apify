class JsonRoutes::ApplicationController < ApplicationController
    
  def index
    routes_file = File.open('apify_resources.json')
    routes = JSON["#{routes_file.read}"]
    routes_file.close

    render :json => routes
  end
    
  def info
    render :json => { version: File.mtime('apify_resources.json') }
  end

end
