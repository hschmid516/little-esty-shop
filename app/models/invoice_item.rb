class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_one :merchant, through: :item

  enum status: {
    pending: 0,
    packaged: 1,
    shipped: 2
  }

  def self.find_by_id(id)
    find(id)
  end

  def find_discount(discount_id)
    Discount.find(discount_id)
  end
end
