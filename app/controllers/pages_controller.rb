class PagesController < ApplicationController
  def home
    @github_id = ENV["GITHUB_ID"]
  end
  def all
    @user = client.user
    @github_results = current_user["github_results"]
    binding.pry
  end
end
