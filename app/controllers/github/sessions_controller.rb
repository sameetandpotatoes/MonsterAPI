class Github::SessionsController < ApplicationController
  include ApplicationHelper
  def create
    session_code = request.env['rack.request.query_hash']['code']
    result = RestClient.post('https://github.com/login/oauth/access_token',
                          {:client_id => ENV["GITHUB_ID"],
                           :client_secret => ENV["GITHUB_SECRET"],
                           :code => session_code},
                           :accept => :json)
    # extract the token and granted scopes
    access_token = JSON.parse(result)['access_token']
    scopes = JSON.parse(result)['scope'].split(',')
    has_user_email_scope = scopes.include? 'user:email'
    @results = JSON.parse(RestClient.get('https://api.github.com/user',
                                        {:params => {:access_token => access_token}}))
    # if the user authorized it, fetch private emails
    if has_user_email_scope
      @results['private_emails'] = JSON.parse(RestClient.get('https://api.github.com/user/emails',{:params => {:access_token => access_token}}))
    end
  end
end
