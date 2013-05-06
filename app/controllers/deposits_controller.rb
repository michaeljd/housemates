class DepositsController < ApplicationController
  # GET /deposits
  # GET /deposits.json
  def index
    @house = House.find(params[:house_id])
    if params[:housemate_id]
      @housemate = @house.housemates.find(params[:housemate_id])
      @deposits = @housemate.deposits
    else
      @deposits = @house.deposits
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @deposits }
    end
  end

  # GET /deposits/1
  # GET /deposits/1.json
  def show
    @house = House.find(params[:house_id])
    if params[:housemate_id]
      @housemate = @house.housemates.find(params[:housemate_id])
      @deposit = @housemate.deposits.find(params[:id])
    else
      @deposit = @house.deposits.find(params[:id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @deposit }
    end
  end

  # GET /deposits/new
  # GET /deposits/new.json
  def new
    @house = House.find(params[:house_id])
    if params[:housemate_id]
      @housemate = @house.housemates.find(params[:housemate_id])
      @deposit = @housemate.deposits.new
    else
      @deposit = @house.deposits.new
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @deposit }
    end
  end

  # GET /deposits/1/edit
  def edit
    @deposit = Deposit.find(params[:id])
  end

  # POST /deposits
  # POST /deposits.json
  def create
    @house = House.find(params[:house_id])
    @housemate = @house.housemates.find(params[:housemate_id])
    @deposit = @housemate.deposits.new(params[:deposit])

    respond_to do |format|
      if @deposit.save
        format.html { redirect_to @house, notice: 'Deposit was successfully created.' }
        format.json { render json: @deposit, status: :created, location: @deposit }
      else
        format.html { render action: "new" }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /deposits/1
  # PUT /deposits/1.json
  def update
    @deposit = Deposit.find(params[:id])

    respond_to do |format|
      if @deposit.update_attributes(params[:deposit])
        format.html { redirect_to @deposit, notice: 'Deposit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  def upload
    respond_to do |format|
      format.html
    end
  end

  def process_upload
    @house = House.find(params[:house_id])
    post = Deposit.import(@house,params[:upload])
    redirect_to deposits_path
  end

  # DELETE /deposits/1
  # DELETE /deposits/1.json
  def destroy
    @deposit = Deposit.find(params[:id])
    @deposit.destroy

    respond_to do |format|
      format.html { redirect_to deposits_url }
      format.json { head :no_content }
    end
  end
end
