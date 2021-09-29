require 'rails_helper'

RSpec.describe 'merchant bulk discounts index' do
  before :each do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)
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
    @disc3 = @merch2.discounts.create(name: 'Other Discount', percentage: 0.50, threshold: 5)
    Discounter.call(@invoice1)
    Discounter.call(@invoice2)
    @json = File.read('spec/fixtures/holidays.json')
    stub_request(:get, "https://date.nager.at/api/v2/NextPublicHolidays/us").
      to_return(status: 200, body: @json)
    visit merchant_discounts_path(@merch1)
  end

  it 'shows all discounts with %, thresholds, link' do
    within("#discount-#{@disc1.id}") do
      expect(page).to have_content(@disc1.name)
      expect(page).to have_content("#{@disc1.percentage * 100}%")
      expect(page).to have_content(@disc1.threshold)
      click_link(@disc1.name)
    end

    expect(current_path).to eq(merchant_discount_path(@merch1, @disc1))

    visit merchant_discounts_path(@merch1)

    within("#discount-#{@disc2.id}") do
      expect(page).to have_content(@disc2.name)
      expect(page).to have_content("#{@disc2.percentage * 100}%")
      expect(page).to have_content(@disc2.threshold)
      click_link(@disc2.name)
    end

    expect(current_path).to eq(merchant_discount_path(@merch1, @disc2))

    visit merchant_discounts_path(@merch1)

    expect(page).to_not have_content(@disc3.name)
  end

  it 'shows next 3 holidays' do
    within('#holidays') do
      within('h1') do
        expect(page).to have_content('Upcoming Holidays')
      end

      expect(page).to have_content('Columbus Day Date: 2021-10-11')
      expect(page).to have_content('Veterans Day Date: 2021-11-11')
      expect(page).to have_content('Thanksgiving Day Date: 2021-11-25')
    end
  end

  it 'can go to new discount page' do
    click_link("Create New Discount")

    expect(current_path).to eq(new_merchant_discount_path(@merch1))
  end

  it 'can delete a discount' do
    expect(page).to have_content(@disc2.name)

    within("#discount-#{@disc2.id}") do
      click_link('Delete')
    end

    expect(current_path).to eq(merchant_discounts_path(@merch1))
    expect(page).to_not have_content(@disc2.name)
  end

  it 'only deletes discount if no pending invoice_items' do
    within("#discount-#{@disc1.id}") do
      click_link('Delete')
    end

    expect(current_path).to eq(merchant_discounts_path(@merch1))
    expect(page).to have_content(@disc1.name)
    expect(page).to have_content("This discount is applied to an item that is pending - Can't delete discount!")
  end
end
