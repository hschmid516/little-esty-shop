class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    holiday_facade = BulkDiscountsFacade.new
    @holidays = holiday_facade.holiday_api
  end

  def show
  end
end
