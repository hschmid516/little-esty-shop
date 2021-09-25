class Discounter
  def initialize(merchant)
    @merchant = merchant
  end

  def self.call(*args)
    new(*args).apply_discount
  end

  def apply_discount
    @merchant.find_discounts.each do |item_discount|
      InvoiceItem.find_by_id(item_discount[0]).update(discount: item_discount[1])
    end
  end
end
