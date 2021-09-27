require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  before :each do
    @merch1 = create(:merchant)
    @discount1 = @merch1.bulk_discounts.create!(percentage_discount: 10, quantity_threshold: 10)
    @discount2 = @merch1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 20)
    @discount3 = @merch1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 30)
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
  end

  describe 'all methods' do
    it '#total_revenue' do
      expect(InvoiceItem.total_revenue).to eq(15000)
    end

    it '#revenue' do
      expect(@ii1.revenue).to eq(15000)
    end

    it '#discounted' do
      actual = InvoiceItem.discounted.map do |ii|
        ii.id
      end

      expected = [@ii1.id]

      expect(actual).to eq(expected)
    end

    it '#revenue_discount' do
      expect(InvoiceItem.revenue_discount).to eq(1500)
    end

    it '#find_max_discount_id' do
      expect(@ii1.find_max_discount_id).to eq(@discount1.id)
    end

    it '#total_amount_discounted_revenue' do
      expect(InvoiceItem.total_amount_discounted_revenue).to eq(13500)
    end

    it '#max_discount' do
      expect(@ii1.max_discount).to eq(@discount1)
    end

    it '#max_discount_percentage' do
      expect(@ii1.max_discount_percentage).to eq(@discount1.percentage_discount)
    end

  end

  describe 'given examples' do
    it 'example1' do
      merch1 = create(:merchant)
      discount1 = merch1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)
      cust1 = create(:customer)
      invoiceA = create(:invoice, customer: cust1)
      item1 = create(:item, merchant: merch1)
      item2 = create(:item, merchant: merch1)
      ii1 = InvoiceItem.create(item: item1, invoice: invoiceA, status: 1, quantity: 5, unit_price: 1000)
      ii2 = InvoiceItem.create(item: item2, invoice: invoiceA, status: 1, quantity: 5, unit_price: 1000)
      create(:transaction, invoice: invoiceA, result: 'success')

      expect(invoiceA.invoice_items.total_revenue).to eq(10000)
      expect(invoiceA.invoice_items.total_amount_discounted_revenue).to eq(10000)
    end

    it 'example2' do
      merch1 = create(:merchant)
      discount1 = merch1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)
      cust1 = create(:customer)
      invoiceA = create(:invoice, customer: cust1)
      item1 = create(:item, merchant: merch1)
      item2 = create(:item, merchant: merch1)
      ii1 = InvoiceItem.create(item: item1, invoice: invoiceA, status: 1, quantity: 10, unit_price: 1000)
      ii2 = InvoiceItem.create(item: item2, invoice: invoiceA, status: 1, quantity: 5, unit_price: 1000)
      create(:transaction, invoice: invoiceA, result: 'success')

      expect(invoiceA.invoice_items.total_revenue).to eq(15000)
      expect(invoiceA.invoice_items.total_amount_discounted_revenue).to eq(13000)
    end

    it 'example3' do
      merch1 = create(:merchant)
      discount1 = merch1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)
      discount2 = merch1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)
      cust1 = create(:customer)
      invoiceA = create(:invoice, customer: cust1)
      item1 = create(:item, merchant: merch1)
      item2 = create(:item, merchant: merch1)
      ii1 = InvoiceItem.create(item: item1, invoice: invoiceA, status: 1, quantity: 12, unit_price: 1000)
      ii2 = InvoiceItem.create(item: item2, invoice: invoiceA, status: 1, quantity: 15, unit_price: 1000)
      create(:transaction, invoice: invoiceA, result: 'success')

      expect(invoiceA.invoice_items.total_revenue).to eq(27000)
      expect(invoiceA.invoice_items.total_amount_discounted_revenue).to eq(20100)
    end

    it 'example4' do
      merch1 = create(:merchant)
      discount1 = merch1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)
      discount2 = merch1.bulk_discounts.create!(percentage_discount: 15, quantity_threshold: 15)
      cust1 = create(:customer)
      invoiceA = create(:invoice, customer: cust1)
      item1 = create(:item, merchant: merch1)
      item2 = create(:item, merchant: merch1)
      ii1 = InvoiceItem.create(item: item1, invoice: invoiceA, status: 1, quantity: 12, unit_price: 1000)
      ii2 = InvoiceItem.create(item: item2, invoice: invoiceA, status: 1, quantity: 15, unit_price: 1000)
      create(:transaction, invoice: invoiceA, result: 'success')

      expect(invoiceA.invoice_items.total_revenue).to eq(27000)
      expect(invoiceA.invoice_items.total_amount_discounted_revenue).to eq(21600)
    end

    it 'example5' do
      merch1 = create(:merchant)
      merch2 = create(:merchant)
      discount1 = merch1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)
      discount2 = merch1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)
      cust1 = create(:customer)
      invoiceA = create(:invoice, customer: cust1)
      item1 = create(:item, merchant: merch1)
      item2 = create(:item, merchant: merch1)
      item3 = create(:item, merchant: merch2)

      ii1 = InvoiceItem.create(item: item1, invoice: invoiceA, status: 1, quantity: 12, unit_price: 1000)
      ii2 = InvoiceItem.create(item: item2, invoice: invoiceA, status: 1, quantity: 15, unit_price: 1000)
      ii2 = InvoiceItem.create(item: item3, invoice: invoiceA, status: 1, quantity: 15, unit_price: 1000)

      create(:transaction, invoice: invoiceA, result: 'success')

      expect(invoiceA.invoice_items.total_revenue).to eq(42000)
      expect(invoiceA.invoice_items.total_amount_discounted_revenue).to eq(35100)
    end
  end
end
