require 'rails_helper'

RSpec.describe 'merchant bulk discounts show page' do
  before :each do
    @merch1 = create(:merchant)
    @disc1 = @merch1.discounts.create(name: 'BOGOHO', percentage: 0.25, threshold: 2)
    @disc2 = @merch1.discounts.create(name: 'Super Saver', percentage: 0.50, threshold: 3)
    visit merchant_discount_path(@merch1, @disc1)
  end

  it 'shows the discount threshold and percentage' do
    within("#discount") do
      expect(page).to have_content(@disc1.name)
      expect(page).to have_content(@disc1.percentage)
      expect(page).to have_content(@disc1.threshold)
      expect(page).to_not have_content(@disc2.name)
      expect(page).to_not have_content(@disc2.percentage)
      expect(page).to_not have_content(@disc2.threshold)
    end
  end

  it 'has link to edit discount' do
    click_link("Edit Discount")

    expect(current_path).to eq(edit_merchant_discount_path(@merch1, @disc1))
  end
end
