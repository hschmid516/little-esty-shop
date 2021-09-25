class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_one :merchant, through: :item

  enum status: {
    pending: 0,
    packaged: 1,
    shipped: 2
  }

  def self.applicable_discount
    joins(item: { merchant: :discounts })
         .where('invoice_items.quantity >= discounts.threshold')
         .group(:id)
         .maximum('discounts.percentage')
  end

  def self.find_by_id(id)
    find(id)
  end
end
