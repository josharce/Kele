module Roadmap
  def get_roadmap
    roadmap_id = self.get_me["current_enrollment"]["roadmap_id"]
    response = self.class.get("/roadmaps/#{roadmap_id}", headers: { "authorization" => @auth_token["auth_token"] }).parsed_response
  end

  def get_checkpoint(id)
    response = self.class.get("/checkpoints/#{id}", headers: { "authorization" => @auth_token["auth_token"] }).parsed_response
  end
end
