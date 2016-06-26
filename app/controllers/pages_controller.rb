class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]

  def home
  end

  def dashboard
    @user = current_user
    @places = @user.places
    @reviews = @user.reviews
  end
end
