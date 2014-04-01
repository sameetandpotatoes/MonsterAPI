class PagesController < ApplicationController
  def home
    @github_id = ENV["GITHUB_ID"]
  end
end
