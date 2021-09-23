require 'rails_helper'

RSpec.describe 'merchant bulk discounts index' do
  before :each do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)
    @disc1 = @merch1.discounts.create(name: 'BOGOHO', percentage: 0.25, threshold: 2)
    @disc2 = @merch1.discounts.create(name: 'Super Saver', percentage: 0.50, threshold: 3)
    @disc3 = @merch2.discounts.create(name: 'Other Discount', percentage: 0.50, threshold: 3)
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
end
