class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: {
    pending: 0,
    packaged: 1,
    shipped: 2
  }

  def self.total_revenue
    sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def revenue
    unit_price * quantity
  end

  def self.discounted
    joins(item: { merchant: :bulk_discounts })
      .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
      .group(:id)
  end

  def self.revenue_discount
    discounted.sum do |invoice_item|
      invoice_item.revenue * invoice_item.max_discount_percentage / 100
    end
  end

  def find_max_discount_id
    max_discount.id
  end

  def self.total_amount_discounted_revenue
    total_revenue - revenue_discount
  end

  def max_discount
    item.merchant.bulk_discounts.max_discount(quantity)
  end

  def max_discount_percentage
    max_discount.percentage_discount
  end
end
