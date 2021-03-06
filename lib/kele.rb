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
    response = self.class.get("/users/me", headers: { "authorization" => @auth_token["auth_token"] }).parsed_response
  end

  def mentor_times
    id = self.get_me["current_enrollment"]["mentor_id"]

    response = self.class.get("/mentors/#{id}/student_availability", headers: { "authorization" => @auth_token["auth_token"] }).parsed_response
  end

  def get_messages(page = 1)
    @page = page

    response = self.class.get("/message_threads", { query: { "page": @page }, headers: { "authorization" => @auth_token["auth_token"] } }).parsed_response
  end

  def create_message(recipient = nil, text = "No message entered.")
    @sender = self.get_me["email"]
    @recipient = recipient
    @text = text

    response = self.class.post("/messages", { query: { "sender": @sender, "recipient_id": @recipient, "stripped-text": @text}, headers: { "authorization" => @auth_token["auth_token"] } })
  end

  def create_submission(checkpoint_id = nil, assignment_branch = nil, assignment_commit_link = nil, comment = "No comment entered.")
    @enrollment_id = self.get_me["current_enrollment"]["id"]
    @checkpoint_id = checkpoint_id
    @assignment_branch = assignment_branch
    @assignment_commit_link = assignment_commit_link
    @comment = comment

    response = self.class.post("/checkpoint_submissions", { query: { "checkpoint_id": @checkpoint_id, "assignment_branch": @assignment_branch, "assignment_commit_link": @assignment_commit_link, "comment": @comment, "enrollment_id": @enrollment_id}, headers: { "authorization" => @auth_token["auth_token"] } })
  end
end
