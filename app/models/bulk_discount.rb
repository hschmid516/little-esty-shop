class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates :quantity_threshold, presence: true
  validates :percentage_discount, presence: true

  def self.max_discount(quantity)
    where('quantity_threshold <= ?', quantity)
      .order(percentage_discount: :desc)
      .first
  end
end
