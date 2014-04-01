class Linkedin::SessionsController < ApplicationController
  include ApplicationHelper
  def create
    # if Rails.env.development?
      url = 'https://www.linkedin.com/uas/oauth2/accessToken?grant_type=authorization_code&code=' + params["code"]+'&redirect_uri=http://localhost:3000/auth/linkedin/callback&client_id='+ENV['LINKED_KEY']+'&client_secret='+ENV['LINKED_SECRET']
    # else
      url = 'https://www.linkedin.com/uas/oauth2/accessToken?grant_type=authorization_code&code=' + params["code"]+'&redirect_uri=http://monsterapi.herokuapp.com/auth/linkedin/callback&client_id='+ENV['LINKED_KEY']+'&client_secret='+ENV['LINKED_SECRET']
    response = postrequest(url)
    @access_token = response["access_token"]
    #Basic Information
    url = 'https://api.linkedin.com/v1/people/~?oauth2_access_token='+@access_token+'&format=json'
    @basic_info = getrequest(url)
    #Connections
    # url = 'https://api.linkedin.com/v1/people/~/connections?&oauth2_access_token='+@access_token+'&format_json'
    # connections = getrequest(url)
    # binding.pry
  end
end
