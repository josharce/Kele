require 'httparty'

class Kele
  include HTTParty  
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    @params = { query: { email: email, password: password } }

    @auth_token = self.class.post("/sessions", @params)
  end

  def get_me
    @current_user = self.class.get("/users/me", headers: { "authorization" => @auth_token["auth_token"] }).parsed_response
  end
end
