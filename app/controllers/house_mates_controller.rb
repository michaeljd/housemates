class HouseMatesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @housemate = HouseMate.new
    @house = House.find(params[:house_id])

    @housemate.house = @house

    #unless can? :create, @housemate
    #  raise CanCan::AccessDenied
    #end

    @user = User.where(:email => params[:user][:email]).first
   
    @housemate.user = @user

    if not (@user.nil? or @house.nil?)
      @dupe = HouseMate.where(:user_id => @user.id, :house_id => @house.id).first
    end

    respond_to do |format|
      if @dupe
        format.html { redirect_to(:back, :alert => 'HouseMate could not be added, '+@user.name+' is already a member of '+@house.name) }
        format.json { render :json => :back.errors, :status => :unprocessable_entity }
      elsif @house.nil?
        format.html { redirect_to(:back, :alert => 'HouseMate could not be added, house could not be found.') }
        format.json { render :json => :back.errors, :status => :unprocessable_entity }
      elsif @user.nil?
        format.html { redirect_to(:back, :alert => 'HouseMate could not be added, user could not be found.') }
        format.json { render :json => :back.errors, :status => :unprocessable_entity }
      elsif @housemate.save
        format.html { redirect_to(:back, :notice => 'HouseMate was successfully added.') }
        format.json { render :json => :back, :status => :added, :location => @house }
      else
        format.html { redirect_to(:back, :alert => 'HouseMate could not be added due to an unknown error.') }
        format.json { render :json => :back.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @housemate = HouseMate.find(params[:id])

    respond_to do |format|
      if @housemate.destroy
        format.html { redirect_to(:back, :notice => 'HouseMate was successfully removed.')  }
        format.json { head :no_content }
      else
        format.html { redirect_to(:back, :alert => 'HouseMate could not be removed due to an unknown error.') }
        format.json { render :json => :back.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    @housemate = HouseMate.find(params[:id])

  end
end
