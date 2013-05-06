class HousematesController < ApplicationController
  # GET /housemates
  # GET /housemates.json
  def index
    @house = House.find(params[:house_id])
    @housemates = @house.housemates

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @housemates }
    end
  end

  # GET /housemates/1
  # GET /housemates/1.json
  def show
    @house = House.find(params[:house_id])
    @housemate = Housemate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @housemate }
    end
  end

  # GET /housemates/new
  # GET /housemates/new.json
  def new
    @house = House.find(params[:house_id])
    @housemate = Housemate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @housemate }
    end
  end

  # GET /housemates/1/edit
  def edit
    @house = House.find(params[:house_id])
    @housemate = Housemate.find(params[:id])
  end

  # POST /housemates
  # POST /housemates.json
  def create
    @house = House.find(params[:house_id])
    @housemate = Housemate.new(params[:housemate])

    respond_to do |format|
      if @housemate.save
        format.html { redirect_to house_housemate_path(@house,@housemate), notice: 'Housemate was successfully created.' }
        format.json { render json: @housemate, status: :created, location: house_housemate_path(@house,@housemate) }
      else
        format.html { render action: "new" }
        format.json { render json: @housemate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /housemates/1
  # PUT /housemates/1.json
  def update
    @house = House.find(params[:house_id])
    @housemate = Housemate.find(params[:id])

    respond_to do |format|
      if @housemate.update_attributes(params[:housemate])
        format.html { redirect_to house_housemate_path(@house,@housemate), notice: 'Housemate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @housemate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /housemates/1
  # DELETE /housemates/1.json
  def destroy
    @house = House.find(params[:house_id])
    @housemate = @house.housemates.find(params[:id])
    @housemate.destroy

    respond_to do |format|
      format.html { redirect_to house_housemates_url(@house) }
      format.json { head :no_content }
    end
  end

  def balance_data
    @house = House.find(params[:house_id])
    @housemate = @house.housemates.find(params[:housemate_id])
    @history = []
    balance = 0
    @housemate.transactions.each do |t|
      balance += t[:amount]
      @history << { :date => t[:date], :balance => balance }
    end

    respond_to do |format|
      format.json
    end
  end
end
