require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices) }
  end

  describe 'class method' do
    before :each do
      @merch1 = create(:merchant)
      @cust1 = create(:customer, first_name: "Bobby")
      @cust2 = create(:customer, first_name: "Tommy")
      @cust3 = create(:customer, first_name: "Mobby")
      @cust4 = create(:customer, first_name: "Lobby")
      @cust5 = create(:customer, first_name: "Cobby")
      @cust6 = create(:customer, first_name: "Sobby")
      @cust7 = create(:customer, first_name: "Wobby")
      @item1 = create(:item, merchant: @merch1)
      @item2 = create(:item, merchant: @merch1)
      @item3 = create(:item, merchant: @merch1)
      @invoice1 = create(:invoice, customer: @cust1)
      @invoice2 = create(:invoice, customer: @cust2)
      @invoice3 = create(:invoice, customer: @cust2)
      @invoice4 = create(:invoice, customer: @cust3)
      @invoice5 = create(:invoice, customer: @cust3)
      @invoice6 = create(:invoice, customer: @cust3)
      @invoice7 = create(:invoice, customer: @cust4)
      @invoice8 = create(:invoice, customer: @cust4)
      @invoice9 = create(:invoice, customer: @cust4)
      @invoice10 = create(:invoice, customer: @cust4)
      @invoice11 = create(:invoice, customer: @cust4)
      @invoice12 = create(:invoice, customer: @cust5)
      @invoice13 = create(:invoice, customer: @cust5)
      @invoice14 = create(:invoice, customer: @cust5)
      @invoice15 = create(:invoice, customer: @cust5)
      @invoice16 = create(:invoice, customer: @cust5)
      @invoice17 = create(:invoice, customer: @cust6)
      @invoice18 = create(:invoice, customer: @cust7)
      @invoice19 = create(:invoice, customer: @cust7)
      InvoiceItem.create(item: @item1, invoice: @invoice1, status: 1)
      InvoiceItem.create(item: @item2, invoice: @invoice2, status: 1)
      InvoiceItem.create(item: @item3, invoice: @invoice2, status: 1)
      InvoiceItem.create(item: @item1, invoice: @invoice2)
      InvoiceItem.create(item: @item1, invoice: @invoice3)
      InvoiceItem.create(item: @item1, invoice: @invoice4)
      InvoiceItem.create(item: @item1, invoice: @invoice5)
      InvoiceItem.create(item: @item1, invoice: @invoice6)
      InvoiceItem.create(item: @item2, invoice: @invoice7)
      InvoiceItem.create(item: @item2, invoice: @invoice8)
      InvoiceItem.create(item: @item2, invoice: @invoice9)
      InvoiceItem.create(item: @item2, invoice: @invoice10)
      InvoiceItem.create(item: @item2, invoice: @invoice11)
      InvoiceItem.create(item: @item2, invoice: @invoice12)
      InvoiceItem.create(item: @item2, invoice: @invoice13)
      InvoiceItem.create(item: @item2, invoice: @invoice14)
      InvoiceItem.create(item: @item2, invoice: @invoice15)
      InvoiceItem.create(item: @item2, invoice: @invoice16)
      InvoiceItem.create(item: @item2, invoice: @invoice17)
      InvoiceItem.create(item: @item2, invoice: @invoice18)
      InvoiceItem.create(item: @item2, invoice: @invoice19)
      create(:transaction, invoice: @invoice1, result: 'success')
      create(:transaction, invoice: @invoice1, result: 'success')
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
      create(:transaction, invoice: @invoice7, result: 'success')
      create(:transaction, invoice: @invoice7, result: 'success')
      create(:transaction, invoice: @invoice8, result: 'success')
      create(:transaction, invoice: @invoice8, result: 'success')
      create(:transaction, invoice: @invoice9, result: 'success')
      create(:transaction, invoice: @invoice9, result: 'success')
      create(:transaction, invoice: @invoice10, result: 'success')
      create(:transaction, invoice: @invoice10, result: 'success')
      create(:transaction, invoice: @invoice11, result: 'success')
      create(:transaction, invoice: @invoice11, result: 'success')
      create(:transaction, invoice: @invoice12, result: 'success')
      create(:transaction, invoice: @invoice12, result: 'success')
      create(:transaction, invoice: @invoice13, result: 'success')
      create(:transaction, invoice: @invoice13, result: 'success')
      create(:transaction, invoice: @invoice14, result: 'success')
      create(:transaction, invoice: @invoice14, result: 'success')
      create(:transaction, invoice: @invoice15, result: 'success')
      create(:transaction, invoice: @invoice15, result: 'success')
      create(:transaction, invoice: @invoice16, result: 'success')
      create(:transaction, invoice: @invoice16, result: 'success')
      create(:transaction, invoice: @invoice17, result: 'success')
      create(:transaction, invoice: @invoice17, result: 'success')
      create(:transaction, invoice: @invoice18, result: 'success')
      create(:transaction, invoice: @invoice18, result: 'success')
      create(:transaction, invoice: @invoice19, result: 'success')
      create(:transaction, invoice: @invoice19, result: 'success')
    end

    it '#top_five' do
      expect(Customer.top_five).to eq([@cust5, @cust4, @cust3, @cust2, @cust7])
    end

    it '#incomplete_invoices' do
      expect(Customer.incomplete_invoices.first.invoice_id).to eq(@invoice1.id)
    end

    it '#created_at_formatted' do
      expect(@cust1.created_at_formatted).to eq("Tuesday, March 27, 2012")
    end
  end
end
