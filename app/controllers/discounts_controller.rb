class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @holidays = DiscountFacade.new.holiday_api
  end
end
