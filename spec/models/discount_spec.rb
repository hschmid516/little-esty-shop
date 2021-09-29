require 'rails_helper'

RSpec.describe Discount do
  it { should belong_to(:merchant) }

  before :each do
    @merch1 = create(:merchant)
    @cust1 = create(:customer)
    @item1 = create(:item, merchant: @merch1)
    @item2 = create(:item, merchant: @merch1)
    @item3 = create(:item, merchant: @merch1)
    @invoice1 = create(:invoice, customer: @cust1, status: 2)
    @invoice2 = create(:invoice, customer: @cust1, status: 2)
    @ii1 = InvoiceItem.create(item: @item1, invoice: @invoice1, status: 0, quantity: 10, unit_price: 1000)
    @ii2 = InvoiceItem.create(item: @item2, invoice: @invoice1, status: 1, quantity: 20, unit_price: 4000)
    @ii3 = InvoiceItem.create(item: @item3, invoice: @invoice2, status: 0, quantity: 30, unit_price: 1000)
    @disc1 = @merch1.discounts.create(name: 'Fall Special', percentage: 0.25, threshold: 20)
    @disc2 = @merch1.discounts.create(name: 'Super Saver', percentage: 0.40, threshold: 35)
    Discounter.call(@invoice1)
    Discounter.call(@invoice2)
  end

  it '#pending_invoice_items?' do
    expect(@disc1.pending_invoice_items?).to be true
    expect(@disc2.pending_invoice_items?).to be false
  end
end
