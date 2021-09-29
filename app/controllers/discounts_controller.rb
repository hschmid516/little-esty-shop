class DiscountsController < ApplicationController
  before_action :find_merchant
  before_action :find_discount, except: [:index, :create, :new]

  def index
    @holidays = DiscountFacade.new.holiday_api
  end

  def new
    @discount = Discount.new
  end

  def create
    @merchant.discounts.create(discount_params)
    redirect_to merchant_discounts_path(@merchant)
  end

  def update
    if !@discount.pending_invoice_items?
      @discount.update(discount_params)
      redirect_to merchant_discount_path(@merchant, @discount)
    else
      redirect_to edit_merchant_discount_path(@merchant, @discount)
      flash[:danger] = "This discount is applied to an item that is pending - Can't edit discount!"
    end
  end

  def destroy
    if !@discount.pending_invoice_items?
      @discount.destroy
      redirect_to merchant_discounts_path(@merchant)
    else
      redirect_to merchant_discounts_path(@merchant)
      flash[:danger] = "This discount is applied to an item that is pending - Can't delete discount!"
    end
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
