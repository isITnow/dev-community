class HomeController < ApplicationController
  def index
    @users = User.limit(16).order(:first_name)
  end
end
