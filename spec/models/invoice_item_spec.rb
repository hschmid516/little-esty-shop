require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  before(:each) do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)
    @cust1 = create(:customer)
    @cust2 = create(:customer)
    @cust3 = create(:customer)
    @cust4 = create(:customer)
    @cust5 = create(:customer)
    @cust6 = create(:customer)
    @cust7 = create(:customer)
    @item1 = create(:item, merchant: @merch1)
    @item2 = create(:item, merchant: @merch1)
    @item3 = create(:item, merchant: @merch1)
    @item4 = create(:item, merchant: @merch2)
    @item5 = create(:item, merchant: @merch2)
    @item6 = create(:item, merchant: @merch2)
    @invoice1 = create(:invoice, customer: @cust1)
    @invoice2 = create(:invoice, customer: @cust2)
    @invoice3 = create(:invoice, customer: @cust3)
    @invoice4 = create(:invoice, customer: @cust4)
    @invoice5 = create(:invoice, customer: @cust5)
    @invoice6 = create(:invoice, customer: @cust6)
    @invoice7 = create(:invoice, customer: @cust7)
    @invoice8 = create(:invoice, customer: @cust7)
    @ii1 = InvoiceItem.create(item: @item1, invoice: @invoice1, status: 1, quantity: 15, unit_price: 1000)
    @ii2 = InvoiceItem.create(item: @item2, invoice: @invoice1, status: 1, quantity: 9, unit_price: 4000)
    @ii3 = InvoiceItem.create(item: @item3, invoice: @invoice1, status: 1, quantity: 25, unit_price: 1000)
    InvoiceItem.create(item: @item3, invoice: @invoice2, status: 1)
    InvoiceItem.create(item: @item1, invoice: @invoice2)
    InvoiceItem.create(item: @item1, invoice: @invoice3)
    InvoiceItem.create(item: @item1, invoice: @invoice4)
    InvoiceItem.create(item: @item1, invoice: @invoice5)
    InvoiceItem.create(item: @item4, invoice: @invoice6)
    InvoiceItem.create(item: @item5, invoice: @invoice7)
    InvoiceItem.create(item: @item6, invoice: @invoice8)
    create(:transaction, invoice: @invoice1, result: 'success')
    create(:transaction, invoice: @invoice1, result: 'failed')
    create(:transaction, invoice: @invoice1, result: 'failed')
    create(:transaction, invoice: @invoice2, result: 'success')
    create(:transaction, invoice: @invoice2, result: 'success')
    create(:transaction, invoice: @invoice3, result: 'success')
    create(:transaction, invoice: @invoice3, result: 'success')
    create(:transaction, invoice: @invoice4, result: 'success')
    create(:transaction, invoice: @invoice4, result: 'success')
    create(:transaction, invoice: @invoice4, result: 'success')
    create(:transaction, invoice: @invoice5, result: 'success')
    create(:transaction, invoice: @invoice5, result: 'success')
    create(:transaction, invoice: @invoice6, result: 'success')
    create(:transaction, invoice: @invoice6, result: 'success')
    create(:transaction, invoice: @invoice6, result: 'success')
    create(:transaction, invoice: @invoice6, result: 'success')
    @disc3 = @merch1.discounts.create(name: 'Mad deals', percentage: 0.75, threshold: 20)
    @disc1 = @merch1.discounts.create(name: 'Fall Special', percentage: 0.25, threshold: 10)
    @disc2 = @merch1.discounts.create(name: 'Super Saver', percentage: 0.50, threshold: 15)
    @disc4 = @merch2.discounts.create(name: 'Lame Deal', percentage: 0.05, threshold: 100)
  end

  it '#applicable_discount' do
    expect(InvoiceItem.applicable_discount).to eq({@ii1.id=>0.5, @ii3.id=>0.75})
  end

  it '#find_by_id' do
    expect(InvoiceItem.find_by_id(@ii1.id)).to eq(@ii1)
  end
end
