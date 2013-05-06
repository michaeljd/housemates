class HomeController < ApplicationController
  def index
    if user_signed_in?
      @user = current_user
      @housemates = @user.house_mates.all
    end
  end
end
