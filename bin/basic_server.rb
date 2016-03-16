require 'rack'

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  res['Content-Type'] = 'text/html'
  my_input = req.path
  res.write("#{my_input}")
  res.finish
end

router = Router.new
router.draw do
  get Regexp.new("^/cats$"), Cats2Controller, :index
  get Regexp.new("^/cats/(?<cat_id>\\d+)/statuses$"), StatusesController, :index
end

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

Rack::Server.start(
app: app,
Port: 3000
)

# def pp(hash)
#   hash.map {|key,value| "#{key} => #{value}"}.sort.join("<br/>")
# end
# Rack::Handler::WEBrick.run lambda {|env| [200,{},[pp(env)]]} , :Port=>3000
