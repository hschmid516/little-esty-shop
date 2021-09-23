class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    item.update(item_params)

    if params[:enable]
      redirect_to merchant_items_path(merchant)
    else
      flash[:notice] = "Item has been updated succesfully"
      redirect_to merchant_item_path(merchant, item)
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.create(item_params)

    if item.save
      redirect_to merchant_items_path(merchant)
      flash[:notice] = "Item has been created succesfully"
    else
      flash[:notice] = "Item not created. Information missing"
      redirect_to new_merchant_item_path(merchant)
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :enable)
  end
end
