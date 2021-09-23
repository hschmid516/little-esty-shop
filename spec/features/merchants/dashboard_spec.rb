require 'rails_helper'

describe 'merchant dashboard page' do
  before(:each) do
    @merch1 = create(:merchant)
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
    @invoice1 = create(:invoice, customer: @cust1)
    @invoice2 = create(:invoice, customer: @cust2)
    @invoice3 = create(:invoice, customer: @cust3)
    @invoice4 = create(:invoice, customer: @cust4)
    @invoice5 = create(:invoice, customer: @cust5)
    @invoice6 = create(:invoice, customer: @cust6)
    @invoice7 = create(:invoice, customer: @cust7)
    @invoice8 = create(:invoice, customer: @cust7)
    InvoiceItem.create(item: @item1, invoice: @invoice1, status: 1)
    InvoiceItem.create(item: @item2, invoice: @invoice2, status: 1)
    InvoiceItem.create(item: @item3, invoice: @invoice2, status: 1)
    InvoiceItem.create(item: @item1, invoice: @invoice2)
    InvoiceItem.create(item: @item1, invoice: @invoice3)
    InvoiceItem.create(item: @item1, invoice: @invoice4)
    InvoiceItem.create(item: @item1, invoice: @invoice5)
    InvoiceItem.create(item: @item1, invoice: @invoice6)
    InvoiceItem.create(item: @item4, invoice: @invoice7)
    InvoiceItem.create(item: @item4, invoice: @invoice8)
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
    create(:transaction, invoice: @invoice7, result: 'success')
    create(:transaction, invoice: @invoice8, result: 'success')
    create(:transaction, invoice: @invoice8, result: 'success')
    create(:transaction, invoice: @invoice8, result: 'success')
    visit merchant_dashboard_path(@merch1)
  end

  it 'shows the name of the merchant' do
    expect(page).to have_content(@merch1.name)
  end

  it 'has link to merchant items index' do
    click_link("My Items")

    expect(current_path).to eq(merchant_items_path(@merch1))

    visit merchant_dashboard_path(@merch1)

    click_link("My Invoices")

    expect(current_path).to eq(merchant_invoices_path(@merch1))
  end

  it 'shows names of top 5 customers and their successful transactions' do
    expect(page).to_not have_content(@cust1.first_name)
    expect(page).to_not have_content(@cust7.first_name)

    within("#customer-#{@cust2.id}") do
      expect(page).to have_content(@cust2.first_name)
      expect(page).to have_content(6)
    end

    within("#customer-#{@cust3.id}") do
      expect(page).to have_content(@cust3.first_name)
      expect(page).to have_content(2)
    end

    within("#customer-#{@cust4.id}") do
      expect(page).to have_content(@cust4.first_name)
      expect(page).to have_content(3)
    end

    within("#customer-#{@cust5.id}") do
      expect(page).to have_content(@cust5.first_name)
      expect(page).to have_content(2)
    end

    within("#customer-#{@cust6.id}") do
      expect(page).to have_content(@cust6.first_name)
      expect(page).to have_content(4)
    end
  end

  it 'shows items ready to ship' do
    within("#item-#{@item1.id}") do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice2.id)
      expect(page).to have_content(@invoice3.id)
    end

    within("#item-#{@item2.id}") do
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@invoice2.id)
    end
  end

  it 'links to invoices' do
    within("#item-#{@item1.id}") do
      click_link("#{@invoice1.id}")

      expect(current_path).to eq("/merchants/#{@merch1.id}/invoices/#{@invoice1.id}")
    end
  end

  it 'shows invoices sorted by created at date' do
    within("#item-#{@item1.id}") do
      expect("#{@invoice1.id}").to appear_before("#{@invoice2.id}")
      expect("#{@invoice2.id}").to appear_before("#{@invoice3.id}")
    end
  end

  it 'shows created at date for invoices formatted' do
    within("#item-#{@item1.id}") do
      expect(page).to have_content(@invoice1.created_at_formatted)
    end
  end

  it 'has a link to all discounts' do
    click_link("My Discounts")

    expect(current_path).to eq(merchant_discounts_path(@merch1))
  end
end
