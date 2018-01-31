require 'httparty'
require 'json'

class Kele
  include HTTParty  
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    @params = { query: { email: email, password: password } }

    @auth_token = self.class.post("/sessions", @params)
  end

  def get_me
    response = self.class.get("/users/me", headers: { "authorization" => @auth_token["auth_token"] })

    JSON.parse(response)
  end
end
