class Admin::InvoicesController < AdminController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
    Discounter.call(@invoice)
  end
end
