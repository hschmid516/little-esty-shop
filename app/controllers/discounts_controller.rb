class DiscountsController < ApplicationController
  before_action :find_merchant
  before_action :find_discount, only: [:show, :destroy]

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

  def destroy
    @discount.destroy
    redirect_to merchant_discounts_path(@merchant)
  end

  private

  def discount_params
    params.require(:discount).permit(:name, :percentage, :threshold)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_discount
    @discount = Discount.find(params[:id])
  end
end
