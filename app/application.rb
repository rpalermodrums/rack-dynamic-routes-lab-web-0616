require "pry"

class Application
  @@items = Item.all

  def call(env)
    req = Rack::Request.new(env)
    resp = Rack::Response.new


    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      if @@items.map(&:name).include?(item_name)
        item = @@items.find { |i| i.name = item_name }
        resp.write "#{item.price}"
        resp.status = 200
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
  resp.finish
  end

end
