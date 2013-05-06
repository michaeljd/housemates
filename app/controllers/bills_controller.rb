class BillsController < ApplicationController
  # GET /bills
  # GET /bills.json
  def index
    @house = House.find(params[:house_id])
    @bills = @house.bills.paginate(:page => params[:page], :per_page => 10).order('paid DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bills }
    end
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
    @house = House.find(params[:house_id])
    @bill = Bill.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bill }
    end
  end

  # GET /bills/new
  # GET /bills/new.json
  def new
    @house = House.find(params[:house_id])
    @bill = Bill.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bill }
    end
  end

  # GET /bills/1/edit
  def edit
    @house = House.find(params[:house_id])
    @bill = @house.bills.find(params[:id])
  end

  # POST /bills
  # POST /bills.json
  def create
    @house = House.find(params[:house_id])
    @bill = Bill.new(params[:bill])
    @bill.paid = nil

    respond_to do |format|
      if @bill.save
        format.html { redirect_to @bill, notice: 'Bill was successfully created.' }
        format.json { render json: @bill, status: :created, location: @bill }
      else
        format.html { render action: "new" }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bills/1
  # PUT /bills/1.json
  def update
    @house = House.find(params[:house_id])
    @bill = @house.bills.find(params[:id])

    respond_to do |format|
      if @bill.update_attributes(params[:bill])
        format.html { redirect_to @bill, notice: 'Bill was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
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
    post = Bill.import(@house,params[:upload])
    redirect_to house_bills_path(@house)
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @house = House.find(params[:house_id])
    @bill = @house.bills.find(params[:id])
    @bill.destroy

    respond_to do |format|
      format.html { redirect_to house_bills_path(@house) }
      format.json { head :no_content }
    end
  end
end
