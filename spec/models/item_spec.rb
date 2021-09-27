require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:unit_price) }
  end

  before :each do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)
    @item1 = create(:item, merchant: @merch1, enable: 0, unit_price: 100)
    @item2 = create(:item, merchant: @merch1, enable: 0, unit_price: 5)
    @item3 = create(:item, merchant: @merch1, unit_price: 5)
    @item4 = create(:item, merchant: @merch2, enable: 0, unit_price: 5)
    @cust1 = create(:customer)
    @cust2 = create(:customer)
    @invoice1 = create(:invoice, customer: @cust1, created_at: '2012-03-27 14:53:59 UTC')
    @invoice2 = create(:invoice, customer: @cust2)
    @ii = InvoiceItem.create(item: @item1, invoice: @invoice1, status: 1, quantity: 3, unit_price: 1000)
    InvoiceItem.create(item: @item2, invoice: @invoice2, status: 1)
    InvoiceItem.create(item: @item3, invoice: @invoice2, status: 1)
  end

  it "shows only enabled items" do
    expect(Item.enabled_items).to eq([@item1, @item2, @item4])
  end

  it "shows only disabled items" do
    expect(Item.disabled_items).to eq([@item3])
  end

  it "#best_day" do
    expect(@item1.best_day.created_at).to eq(@invoice1.created_at.strftime('%Y-%m-%d'))
  end

  it "#revenue" do
    expect(@item1.revenue).to eq(@ii.unit_price * @ii.quantity)
  end

  it '#invoice_items_by_merchant_id' do
    expect(@invoice1.invoice_items_by_merchant_id(@merch1.id)).to eq([@ii])
  end

  it '#total_revenue_by_merchant_id' do
    expect(@invoice1.total_revenue_by_merchant_id(@merch1.id)).to eq(3000)
  end
end
