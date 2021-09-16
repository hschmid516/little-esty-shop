class InvoiceItemsController < ApplicationController
  def update
    merchant = Merchant.find(params[:merchant_id])
    invoice = Invoice.find(params[:id])
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    invoice_item.update(invoice_item_params)

    redirect_to "/merchants/#{merchant.id}/invoices/#{invoice.id}"
  end

  private

  def invoice_item_params
    params.permit(:status)
  end
end
