class Application
  @@items = []

  def call(env)
    response = Rack::Response.new
    request = Rack::Request.new(env)

    if request.path.match(/items/)
      search_term = request.path.split('/items/').last
      if item = @@items.find { |i| i.name == search_term }
        response.write item.price
        response.status = 200
      else
        response.write "Item not found"
        response.status = 400
      end
    else
      response.status = 404
      response.write "Route not found"
    end
    response.finish
  end
end
