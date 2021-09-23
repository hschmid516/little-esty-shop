class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates :quantity_threshold, presence: true
  validates :percentage_discount, presence: true
end
