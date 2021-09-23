require 'rails_helper'

RSpec.describe 'merchant bulk discounts index' do
  before :each do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)
    @disc1 = @merch1.discounts.create(name: 'BOGOHO', percentage: 0.25, threshold: 2)
    @disc2 = @merch1.discounts.create(name: 'Super Saver', percentage: 0.50, threshold: 3)
    @disc3 = @merch2.discounts.create(name: 'Other Discount', percentage: 0.50, threshold: 3)
    json = File.read('spec/fixtures/holidays.json')
    stub_request(:get, "https://date.nager.at/api/v2/NextPublicHolidays/us").
      to_return(status: 200, body: json)
    visit merchant_discounts_path(@merch1)
  end

  it 'shows all discounts with % and thresholds' do
    within("#discount-#{@disc1.id}") do
      expect(page).to have_content(@disc1.name)
      expect(page).to have_content(@disc1.percentage)
      expect(page).to have_content(@disc1.threshold)
    end

    within("#discount-#{@disc2.id}") do
      expect(page).to have_content(@disc2.name)
      expect(page).to have_content(@disc2.percentage)
      expect(page).to have_content(@disc2.threshold)
    end

    expect(page).to_not have_content(@disc3.name)
  end

  it 'shows next 3 holidays' do
    within('#holidays') do
      within('h1') do
        expect(page).to have_content('Upcoming Holidays')
      end
      expect(page).to have_content('h')
    end
  end

  it 'can create new discount' do
    click_link("Create New Discount")

    expect(current_path).to eq(new_merchant_discount_path(@merch1))

    fill_in('Name', with: 'Ultra Saver')
    fill_in('Discount Percentage', with: 0.75)
    fill_in('Quantity Threshold', with: 4)
    click_button('Create Discount')

    expect(current_path).to eq(merchant_discounts_path(@merch1))

    expect(page).to have_content('Ultra Saver')
    expect(page).to have_content(0.75)
    expect(page).to have_content(4)
  end

  it 'can delete a discount' do
    within("#discount-#{@disc1.id}") do
      click_link('Delete')

      expect(current_path).to eq(merchant_discounts_path(@merch1))
    end
  end
end

# save_and_open_page
