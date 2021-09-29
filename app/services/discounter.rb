class Discounter
  def initialize(invoice)
    @invoice = invoice
  end

  def self.call(*args)
    new(*args).apply_discount
  end

  def apply_discount
    @invoice.applicable_discounts.each do |invoice_item|
      ii = InvoiceItem.find_by_id(invoice_item.id)
      if ii.discount.nil? && @invoice.status == 'completed'
        ii.update(discount: invoice_item.percentage, discount_id: invoice_item.discount_id)
      end
    end
  end
end
