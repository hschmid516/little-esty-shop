class AddDiscountToInvoiceItem < ActiveRecord::Migration[5.2]
  def change
    add_column :invoice_items, :discount, :float
  end
end
