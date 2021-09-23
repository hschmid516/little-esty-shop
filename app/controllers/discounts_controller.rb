class DiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :new, :create]
  def index
    @holidays = DiscountFacade.new.holiday_api
  end

  def new
    @discount = Discount.new(params[:id])
  end

  def create
    @merchant.discounts.create(discount_params)
    redirect_to merchant_discounts_path(@merchant)
  end

  private

  def discount_params
    params.require(:discount).permit(:name, :percentage, :threshold)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
