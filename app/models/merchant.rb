class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :discounts, dependent: :destroy
  validates :name, presence: true

  enum status: {
    enabled: 0,
    disabled: 1
  }

  def self.alphabetical
    order(:name)
  end

  def self.enabled
    where(status: 0).order(:name)
  end

  def self.disabled
    where(status: 1).order(:name)
  end

  def self.top_five
    joins(items: {invoice_items: {invoice: :transactions}})
    .select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .merge(Transaction.purchase)
    .group(:id)
    .order(revenue: :desc)
    .limit(5)
  end

  def favorite_customers
    Customer.select("customers.*, COUNT(transactions.result) AS purchases")
      .joins(invoices: [:items, :transactions])
      .where('items.merchant_id = ?', id)
      .merge(Transaction.purchase)
      .group(:id)
      .order(purchases: :desc)
      .limit(5)
  end

  def items_ready_to_ship
    items.joins(:invoice_items)
      .where.not('invoice_items.status = ?', 2)
  end

  def top_five_items
    items.joins(invoice_items: {invoice: :transactions})
      .select("items.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .merge(Transaction.purchase)
      .group(:id)
      .order(revenue: :desc)
      .limit(5)
  end

  def all_invoices
    Invoice.joins(:items)
      .where("items.merchant_id = ?", id)
      .group(:id)
      .order(:id)
  end

  def best_day
    Merchant.joins(items: {invoice_items: :invoice})
      .select("merchants.*, invoices.created_at AS date_created, SUM(invoice_items.quantity * invoice_items.unit_price) AS sales")
      .where("merchants.id = ?", id)
      .group(:id, :date_created)
      .order(sales: :desc, date_created: :desc)
      .limit(1)
      .first
  end

  def created_at_formatted
    date_created.strftime("%A, %B %d, %Y")
  end
end
