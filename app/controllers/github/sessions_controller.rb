class Github::SessionsController < ApplicationController
  include ApplicationHelper
  def create
    session_code = request.env['rack.request.query_hash']['code']
    result = RestClient.post('https://github.com/login/oauth/access_token',
                          {:client_id => ENV["GITHUB_ID"],
                           :client_secret => ENV["GITHUB_SECRET"],
                           :code => session_code},
                           :accept => :json)
    access_token = JSON.parse(result)['access_token']
    scopes = JSON.parse(result)['scope'].split(',')
    @results = JSON.parse(RestClient.get('https://api.github.com/user',
                                        {:params => {:access_token => access_token}}))
    @results["repos"] = getrequest(@results['repos_url'])
    if (!current_user.nil?)
      current_user["github_results"] = @results
      current_user.save!
      redirect_to "/auth/linkedin"
    end
  end
end
