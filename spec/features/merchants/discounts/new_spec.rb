require 'rails_helper'

RSpec.describe 'new discounts page' do
  before :each do
    @merch1 = create(:merchant)
    @disc1 = @merch1.discounts.create(name: 'Fall Special', percentage: 0.25, threshold: 10)
    json = File.read('spec/fixtures/holidays.json')
    stub_request(:get, "https://date.nager.at/api/v2/NextPublicHolidays/us").
      to_return(status: 200, body: json)
    visit new_merchant_discount_path(@merch1)
  end

  it 'can create a new discount' do
    fill_in('Name', with: 'Ultra Saver')
    fill_in('Discount Percentage', with: 0.75)
    fill_in('Quantity Threshold', with: 4)
    click_button('Create Discount')

    expect(current_path).to eq(merchant_discounts_path(@merch1))

    expect(page).to have_content('Ultra Saver')
    expect(page).to have_content(0.75)
    expect(page).to have_content(4)
  end

  it 'doesnt create new discount if a better one exists' do
    fill_in('Name', with: 'Ultra Saver')
    fill_in('Discount Percentage', with: 0.15)
    fill_in('Quantity Threshold', with: 12)
    click_button('Create Discount')

    expect(current_path).to eq(new_merchant_discount_path(@merch1))

    expect(page).to have_content("There's already a better deal than this...Try again.")
  end
end
