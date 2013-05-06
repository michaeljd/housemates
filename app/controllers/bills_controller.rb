class BillsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @house = House.find(params[:house_id])
    @bill = @house.bills.new

    @house.house_mates.each do |housemate|
    	@bill.bill_parts.new(:house_mate => housemate)
    end

    render :layout => !request.xhr?
  end

  def create
    @house = House.find(params[:house_id])

    params[:bill][:due] = Time.strptime(params[:bill][:due], "%Y-%m-%d")
    @bill = @house.bills.new(params[:bill])

    params[:bill_parts].each_value { |bill_part| @bill.bill_parts.build(bill_part) }

    respond_to do |format|
      if @bill.save and @bill.bill_parts.each { |bill_part| bill_part.save }
        format.html { redirect_to house_bills_path(@house), :notice => 'Bill was successfully added.' }
        format.json { render :json => @bill, :status => :added, :location => @house }
      else
        format.html { render :action => "new" }
	format.json { render :json => @bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @bill = Bill.find(params[:id])
    @house = @bill.house

    params[:bill][:due] = Time.strptime(params[:bill][:due], "%Y-%m-%d")

    respond_to do |format|
      if @bill.update_attributes(params[:bill]) and @bill.bill_parts.each { |bill_part| bill_part.update_attributes (params[:bill_part][bill_part.id.to_s]) }
        format.html { redirect_to house_bills_path(@house), :notice => 'Bill was successfully updated.' }
	format.json { head :no_content }
      else
       format.html { render :action => "edit" }
       format.json { render :json => @bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  def pay
    @bill = Bill.find(params[:id])
    @house = @bill.house

    respond_to do |format|
      if @bill.update_attributes(:paid => true)
        format.html { redirect_to house_path(@house), :notice => 'Bill was successfully updated.' }
	format.json { head :no_content }
	format.js { render :nothing => true }
      else
        format.html { redirect_to house_path(@house), :alert => 'Error updating bill.' }
        format.json { render :json => @bill.errors, :status => :unprocessable_entity }
	format.js { render :nothing => true }
      end
    end
  end

  def index
    @house = House.find(params[:house_id])
    @bills = @house.bills.asc(:due).desc(:amount)

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @bill = Bill.find(params[:id])

    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
    @bill = Bill.find(params[:id])
    @house = @bill.house

    respond_to do |format|
      format.html # edit.html.erb
      format.json { render json: @bill }
    end
  end

  def destroy
    @bill = Bill.find(params[:id])

    respond_to do |format|
      if @bill.destroy
        format.html { redirect_to(:back, :notice => 'Bill was successfully removed.')  }
        format.json { head :no_content }
      else
        format.html { redirect_to(:back, :alert => 'Bill could not be removed due to an unknown error.') }
        format.json { render :json => :back.errors, :status => :unprocessable_entity }
      end
    end
  end
end
