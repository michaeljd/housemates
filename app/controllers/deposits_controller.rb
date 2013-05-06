class DepositsController < ApplicationController

  def create
    @housemate = HouseMate.find(params[:house_mate_id])

    params[:deposit][:date] = Time.strptime(params[:deposit][:date], "%Y-%m-%d")
    @deposit = @housemate.deposits.new(params[:deposit])

    respond_to do |format|
      if @deposit.save
        format.html { redirect_to house_path(@housemate.house), :notice => 'Deposit was successfully added.' }
        format.json { render :json => @deposit, :status => :added, :location => @house }
      else
        format.html { render :action => "new" }
	format.json { render :json => @deposit.errors, :status => :unprocessable_entity }
      end
    end
  end

  def new
    @housemate = HouseMate.find(params[:house_mate_id])
    @deposit = @housemate.deposits.new
    render :layout => !request.xhr?
  end

end
