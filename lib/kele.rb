require 'httparty'
require 'JSON'
require_relative "roadmap"

class Kele
  include HTTParty
  include Roadmap  
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    @params = { query: { email: email, password: password } }

    @auth_token = self.class.post("/sessions", @params)
  end

  def get_me
    response = self.class.get("/users/me", headers: { "authorization" => @auth_token["auth_token"] })

    JSON.parse(response.body)
  end

  def mentor_times
    id = self.get_me["current_enrollment"]["mentor_id"]
    response = self.class.get("/mentors/#{id}/student_availability", headers: { "authorization" => @auth_token["auth_token"] })

    JSON.parse(response.body)
  end
end
