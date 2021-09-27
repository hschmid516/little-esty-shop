class Invoice < ApplicationRecord
  belongs_to :customer

  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: {
    'in progress': 0,
    cancelled: 1,
    completed: 2,
  }

  def created_at_formatted
    created_at.strftime("%A, %B %d, %Y")
  end

  def created_at_short_format
    created_at.strftime("%x")
  end

  def customer_by_id
    Customer.find(customer_id)
  end

  def item_unit_price(item_id)
    invoice_items.where(item_id: item_id).first.unit_price
  end

  def item_status(item_id)
    invoice_items.where(item_id: item_id).first.status
  end

  def total_revenue
    invoice_items.where(invoice_id: id).sum('quantity * unit_price')
  end

  def total_revenue_by_merchant_id(merchant_id)
    invoice_items_by_merchant_id(merchant_id).sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def invoice_items_by_merchant_id(merchant_id)
    invoice_items.joins(item: :merchant).where(items: {merchant_id: merchant_id})
  end
end
