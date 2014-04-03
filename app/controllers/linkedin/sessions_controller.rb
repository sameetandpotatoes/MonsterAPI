class Linkedin::SessionsController < ApplicationController
  include ApplicationHelper
  def create
    url = 'https://www.linkedin.com/uas/oauth2/accessToken?grant_type=authorization_code&code=' + params["code"]+'&redirect_uri=' + ENV['URL'] + '/auth/linkedin/callback&client_id='+ENV['LINKED_KEY']+'&client_secret='+ENV['LINKED_SECRET']
    response = postrequest(url)
    @access_token = response["access_token"]
    url = 'https://api.linkedin.com/v1/people/~?oauth2_access_token='+@access_token+'&format=json'
    @basic_info = getrequest(url)
    #Connections
    # url = 'https://api.linkedin.com/v1/people/~/connections?&oauth2_access_token='+@access_token+'&format_json'
    # connections = getrequest(url)
    if !current_user.nil?
      current_user["linkedin_results"] = @basic_info
      current_user.save!
      redirect_to all_path
    end
  end
end
