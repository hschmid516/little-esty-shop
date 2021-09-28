class Discount < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, through: :merchant

  def pending_invoice_items?
    !invoice_items.where(status: 0, discount_id: id).empty?
  end
end
