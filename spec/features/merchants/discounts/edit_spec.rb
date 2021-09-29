require 'rails_helper'

RSpec.describe 'merchant bulk discounts edit page' do
  before :each do
    @merch1 = create(:merchant)
    @cust1 = create(:customer)
    @item1 = create(:item, merchant: @merch1)
    @item2 = create(:item, merchant: @merch1)
    @item3 = create(:item, merchant: @merch1)
    @invoice1 = create(:invoice, customer: @cust1)
    @invoice2 = create(:invoice, customer: @cust1)
    @ii1 = InvoiceItem.create(item: @item1, invoice: @invoice1, status: 0, quantity: 10, unit_price: 1000)
    @ii2 = InvoiceItem.create(item: @item2, invoice: @invoice1, status: 1, quantity: 20, unit_price: 4000)
    @ii3 = InvoiceItem.create(item: @item3, invoice: @invoice2, status: 1, quantity: 30, unit_price: 1000)
    @disc1 = @merch1.discounts.create(name: 'Fall Special', percentage: 0.25, threshold: 25)
    @disc2 = @merch1.discounts.create(name: 'Super Saver', percentage: 0.40, threshold: 5)
    Discounter.call(@invoice1)
    Discounter.call(@invoice2)
    visit edit_merchant_discount_path(@merch1, @disc1)
  end

  it 'has a pre-populated form' do
    expect(page).to have_field('Name', with: @disc1.name)
    expect(page).to have_field('Discount Percentage', with: @disc1.percentage)
    expect(page).to have_field('Quantity Threshold', with: @disc1.threshold)
  end

  it 'can edit some discount information' do
    fill_in('Name', with: 'Super Deal')
    click_button('Update Discount')

    expect(current_path).to eq(merchant_discount_path(@merch1, @disc1))

    within("#discount") do
      expect(page).to have_content('Super Deal')
      expect(page).to_not have_content(@disc1.name)
    end
  end

  it 'can edit all discount information' do
    fill_in('Name', with: 'Super Deal')
    fill_in('Discount Percentage', with: 0.5)
    fill_in('Quantity Threshold', with: 6)
    click_button('Update Discount')

    expect(current_path).to eq(merchant_discount_path(@merch1, @disc1))

    within("#discount") do
      expect(page).to have_content('Super Deal')
      expect(page).to have_content(0.5)
      expect(page).to have_content(6)
      expect(page).to_not have_content(@disc1.name)
    end
  end

  it 'only edits discount if no pending invoice_items' do
    visit edit_merchant_discount_path(@merch1, @disc2)
    fill_in('Name', with: 'Super Deal')
    click_button('Update Discount')

    expect(current_path).to eq(edit_merchant_discount_path(@merch1, @disc2))
    expect(page).to have_content("This discount is applied to an item that is pending - Can't edit discount!")
    expect(page).to have_content('Super Saver')
  end
end
