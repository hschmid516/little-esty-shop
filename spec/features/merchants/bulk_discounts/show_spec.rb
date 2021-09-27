require 'rails_helper'

RSpec.describe 'Merchant Bulk Discounts Show' do
  before :each do
    @merch1 = create(:merchant)
    @discount1 = @merch1.bulk_discounts.create!(percentage_discount: 10, quantity_threshold: 10)
    @discount2 = @merch1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 20)
    @discount3 = @merch1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 30)
    @cust1 = create(:customer)
    @cust2 = create(:customer)
    @item1 = create(:item, merchant: @merch1)
    @item2 = create(:item, merchant: @merch1)
    @item3 = create(:item, merchant: @merch1)
    @invoice1 = create(:invoice, customer: @cust1)
    @invoice2 = create(:invoice, customer: @cust2)
    @invoice3 = create(:invoice, customer: @cust2)
    InvoiceItem.create(item: @item1, invoice: @invoice1, unit_price: 1000)
    InvoiceItem.create(item: @item2, invoice: @invoice2, unit_price: 1000)
    InvoiceItem.create(item: @item3, invoice: @invoice2, unit_price: 1000)
    InvoiceItem.create(item: @item1, invoice: @invoice2, unit_price: 1000)
    InvoiceItem.create(item: @item1, invoice: @invoice3, unit_price: 1000)
    create(:transaction, invoice: @invoice1, result: 'success')
    create(:transaction, invoice: @invoice1, result: 'success')
    create(:transaction, invoice: @invoice1, result: 'failed')
    create(:transaction, invoice: @invoice2, result: 'success')
    create(:transaction, invoice: @invoice2, result: 'success')
    create(:transaction, invoice: @invoice3, result: 'success')
    create(:transaction, invoice: @invoice3, result: 'success')

    visit merchant_bulk_discount_path(@merch1, @discount1)
  end

  describe 'User Story 5: Merchant Bulk Discount Show' do
    it 'shows a bulk discounts info' do
      expect(page).to have_content(@discount1.quantity_threshold)
      expect(page).to have_content(@discount1.percentage_discount)
    end
  end

  describe 'User Story 6: Merchant Bulk Discount Edit' do
    it 'shows an edit button' do
      expect(page).to have_link("Edit Discount")
    end

    it 'redirects you to an edit form' do
      expect(page).to_not have_content(999)
      expect(page).to_not have_content(888)

      click_link("Edit Discount")

      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merch1, @discount1))

      expect(page).to have_field(:bulk_discount_percentage_discount)
      expect(page).to have_field(:bulk_discount_quantity_threshold)
      expect(page).to have_button(:commit)
      fill_in(:bulk_discount_percentage_discount, with: 999)
      fill_in(:bulk_discount_quantity_threshold, with: 888)
      click_button(:commit)

      expect(current_path).to eq(merchant_bulk_discount_path(@merch1, @discount1))

      expect(page).to have_content(999)
      expect(page).to have_content(888)
    end
  end
end
