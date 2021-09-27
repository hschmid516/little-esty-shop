class AddDiscountIdToInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    add_column :invoice_items, :discount_id, :bigint
  end
end
