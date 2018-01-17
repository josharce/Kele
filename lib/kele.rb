require 'httparty'

class Kele
  include HTTParty  
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    @params = { query: { email: email, password: password } }

    @auth_token = self.class.post("/sessions", @params)
  end
end
