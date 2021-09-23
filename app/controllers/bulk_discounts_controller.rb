class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    holiday_facade = BulkDiscountsFacade.new
    @holidays = holiday_facade.holiday_api
  end

  def show
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    bulk_discount = @merchant.bulk_discounts.create(bulk_discount_params)
    if bulk_discount.save
      flash.notice = 'Success! A new bulk discount was created.'
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      flash.alert = "Incorrect Information. Please submit again."
      redirect_to new_merchant_bulk_discount_path(@merchant)
    end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.destroy!

    flash.notice = 'The bulk discount was deleted successfully.'
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  private

  def bulk_discount_params
    params.required(:bulk_discount).permit(:percentage_discount, :quantity_threshold)
  end

end
