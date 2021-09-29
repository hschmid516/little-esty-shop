class Discount < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, through: :merchant

  def pending_invoice_items?
    !invoice_items.where(status: 0, discount_id: id).empty?
  end

  def self.discount_applicable?(discount_params, merchant_id)
    where('threshold <= ? AND percentage > ? AND merchant_id = ?', discount_params[:threshold], discount_params[:percentage], merchant_id).empty?
  end
end
