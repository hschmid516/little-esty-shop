require 'rails_helper'

RSpec.describe 'Admin Invoices Index' do
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

    visit merchant_bulk_discounts_path(@merch1)
  end

  describe 'Merchant Bulk Discounts Index' do
    it 'displays information about all bulk discounts' do
      expect(page).to have_content(@merch1.name)
      # save_and_open_page
      within("#discount-#{@discount1.id}") do
        expect(page).to have_content(@discount1.quantity_threshold)
        expect(page).to have_content(@discount1.percentage_discount)
        expect(page).to have_link("#{@discount1.id}")
      end

      within("#discount-#{@discount2.id}") do
        expect(page).to have_content(@discount2.quantity_threshold)
        expect(page).to have_content(@discount2.percentage_discount)
        expect(page).to have_link("#{@discount2.id}")
      end

      within("#discount-#{@discount3.id}") do
        expect(page).to have_content(@discount3.quantity_threshold)
        expect(page).to have_content(@discount3.percentage_discount)
        expect(page).to have_link("#{@discount3.id}")
      end
    end

    it 'links to a merchant bulk discounts show page' do
      visit merchant_bulk_discounts_path(@merch1)
      expect(page).to have_content(@merch1.name)

      within("#discount-#{@discount1.id}") do
        click_link("#{@discount1.id}")
      end

      expect(current_path).to eq(merchant_bulk_discount_path(@merch1, @discount1))
    end
  end

  describe 'User story 2: Upcoming Holidays' do
    it 'shows next 3 upcoming holidays' do
      expect(page).to have_content("Upcoming Holidays")
      expect(page).to have_content("Columbus Day")
      expect(page).to have_content("Veterans Day")
      expect(page).to have_content("Thanksgiving Day")
    end
  end

  describe 'User Story 3: Merchant Bulk Discount Create' do
    it 'has a link to create a new discount' do
      expect(page).to have_link("Create a New Discount")
    end

    it 'links you to a new page with a create discount form' do
      click_link("Create a New Discount")

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merch1))

      expect(page).to have_field(:bulk_discount_percentage_discount)
      expect(page).to have_field(:bulk_discount_quantity_threshold)
      expect(page).to have_button("Create Bulk discount")
      fill_in(:bulk_discount_percentage_discount, with: 999)
      fill_in(:bulk_discount_quantity_threshold, with: 888)
      click_button("Create Bulk discount")

      expect(current_path).to eq(merchant_bulk_discounts_path(@merch1))

      expect(page).to have_content(999)
      expect(page).to have_content(888)
    end

    it 'gives you an error if form incorrectly filled out' do
      click_link("Create a New Discount")

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merch1))

      expect(page).to have_field(:bulk_discount_percentage_discount)
      expect(page).to have_field(:bulk_discount_quantity_threshold)
      expect(page).to have_button("Create Bulk discount")
      fill_in(:bulk_discount_percentage_discount, with: 999)

      click_button("Create Bulk discount")

      expect(page).to have_content("Incorrect Information. Please submit again.")
    end
  end

  describe 'User Story 4: Merchant Bulk Discount Delete' do
    it 'shows a delete button for each bulk discount' do
      expect(page).to have_content(@discount1.id)

      within("#discount-#{@discount1.id}") do
        expect(page).to have_link("Delete This Discount")
        click_link("Delete This Discount")
      end

      expect(page).to have_content('The bulk discount was deleted successfully.')
      expect(page).to_not have_content(@discount1.id)
    end
  end
end
