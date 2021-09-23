require 'rails_helper'

RSpec.describe 'merchant bulk discounts edit page' do
  before :each do
    @merch1 = create(:merchant)
    @disc1 = @merch1.discounts.create(name: 'BOGOHO', percentage: 0.25, threshold: 2)
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
end
