require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)

    @req = req
    if @req.cookies["_rails_lite_app"].nil?
      @data = {}
    else
      cook_e = @req.cookies["_rails_lite_app"]
      hash_results = JSON.parse(cook_e)
      @data = hash_results
    end
  end

  def [](key)
    @data[key]
  end

  def []=(key, val)
    @data[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    res.set_cookie("_rails_lite_app", {value: @data.to_json, path: "/"})
  end

end

#rails is doing this
# @session = Session.new
# attr_accessor :session
#
# session[:session_token] = 123445
