class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  def self.top_five
    Customer.joins(invoices: :transactions)
            .select('customers.*, COUNT(transactions.result) as successful')
            .group('customers.id')
            .merge(Transaction.purchase)
            .order(successful: :desc, first_name: :asc, last_name: :asc)
            .limit(5)
  end

  def self.incomplete_invoices
    Customer.joins(invoices: :invoice_items)
            .select("invoices.id as invoice_id, invoices.created_at as created_at")
            .where.not("invoice_items.status = ?", 2)
            .group("invoices.id")
            .order("invoices.id, invoices.created_at")
  end

  def created_at_formatted
    created_at.strftime("%A, %B %d, %Y")
  end
end
