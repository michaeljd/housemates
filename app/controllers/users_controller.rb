class UsersController < ApplicationController
  before_filter :authenticate_user!
  #load_and_authorize_resource :only => :index

  def index
    @housemates = current_user.house_mates
    if current_user.has_role? :admin
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
    @housemates = @user.house_mates
  end
end
