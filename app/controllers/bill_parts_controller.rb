class BillPartsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @bill = Bill.find(params[:bill_id])

    @bill_part = @bill.bill_parts.create(params[:bill_part])
    redirect_to edit_house_bill_path(@bill.house,@bill)
  end

  def destroy
    @bill = Bill.find(params[:bill_id])
    @bill_part = @bill.bill_parts.find(params[:id])
    @bill_part.destroy

    redirect_to edit_house_bill_path(@bill.house,@bill)
  end
end
