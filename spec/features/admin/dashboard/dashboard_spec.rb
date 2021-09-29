require 'rails_helper'

RSpec.describe 'Admin dashboard' do

  before :each do
    @merch1 = create(:merchant)
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
    @invoice1 = create(:invoice, customer: @cust1, created_at: "2012-04-27 14:53:59 UTC")
    @invoice2 = create(:invoice, customer: @cust2)
    @invoice3 = create(:invoice, customer: @cust2)
    @invoice4 = create(:invoice, customer: @cust3)
    @invoice5 = create(:invoice, customer: @cust3)
    @invoice6 = create(:invoice, customer: @cust3)
    @invoice7 = create(:invoice, customer: @cust4)
    @invoice8 = create(:invoice, customer: @cust4)
    @invoice9 = create(:invoice, customer: @cust4)
    @invoice10 = create(:invoice, customer: @cust4)
    @invoice11 = create(:invoice, customer: @cust4)
    @invoice12 = create(:invoice, customer: @cust5)
    @invoice13 = create(:invoice, customer: @cust5)
    @invoice14 = create(:invoice, customer: @cust5)
    @invoice15 = create(:invoice, customer: @cust5)
    @invoice16 = create(:invoice, customer: @cust5)
    @invoice17 = create(:invoice, customer: @cust6)
    @invoice18 = create(:invoice, customer: @cust7)
    @invoice19 = create(:invoice, customer: @cust7)
    InvoiceItem.create(item: @item1, invoice: @invoice1, status: 1, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item2, invoice: @invoice2, status: 1, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item3, invoice: @invoice2, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item1, invoice: @invoice2, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item1, invoice: @invoice3, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item1, invoice: @invoice4, status: 0, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item1, invoice: @invoice5, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item1, invoice: @invoice6, status: 0, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item2, invoice: @invoice7, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item2, invoice: @invoice8, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item2, invoice: @invoice9, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item2, invoice: @invoice10, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item2, invoice: @invoice11, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item2, invoice: @invoice12, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item2, invoice: @invoice13, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item2, invoice: @invoice14, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item2, invoice: @invoice15, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item2, invoice: @invoice16, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item2, invoice: @invoice17, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item2, invoice: @invoice18, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item2, invoice: @invoice19, unit_price: 1000, quantity: 1)
    create(:transaction, invoice: @invoice1, result: 'success')
    create(:transaction, invoice: @invoice1, result: 'success')
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
    create(:transaction, invoice: @invoice7, result: 'success')
    create(:transaction, invoice: @invoice7, result: 'success')
    create(:transaction, invoice: @invoice8, result: 'success')
    create(:transaction, invoice: @invoice8, result: 'success')
    create(:transaction, invoice: @invoice9, result: 'success')
    create(:transaction, invoice: @invoice9, result: 'success')
    create(:transaction, invoice: @invoice10, result: 'success')
    create(:transaction, invoice: @invoice10, result: 'success')
    create(:transaction, invoice: @invoice11, result: 'success')
    create(:transaction, invoice: @invoice11, result: 'success')
    create(:transaction, invoice: @invoice12, result: 'success')
    create(:transaction, invoice: @invoice12, result: 'success')
    create(:transaction, invoice: @invoice13, result: 'success')
    create(:transaction, invoice: @invoice13, result: 'success')
    create(:transaction, invoice: @invoice14, result: 'success')
    create(:transaction, invoice: @invoice14, result: 'success')
    create(:transaction, invoice: @invoice15, result: 'success')
    create(:transaction, invoice: @invoice15, result: 'success')
    create(:transaction, invoice: @invoice16, result: 'success')
    create(:transaction, invoice: @invoice16, result: 'success')
    create(:transaction, invoice: @invoice17, result: 'success')
    create(:transaction, invoice: @invoice17, result: 'success')
    create(:transaction, invoice: @invoice18, result: 'success')
    create(:transaction, invoice: @invoice18, result: 'success')
    create(:transaction, invoice: @invoice19, result: 'success')
    create(:transaction, invoice: @invoice19, result: 'success')

    visit admin_path
  end

  it 'shows that you are on the admin dashboard' do
    within('h1') do
      expect(page).to have_content("Admin Dashboard")
    end
  end

  it 'has a link to the admin merchants index' do
    expect(page).to have_link("All Merchants")
  end

  it 'has a link to the admin merchants index' do
    expect(page).to have_link("All Invoices")
  end

  it 'takes you to the admin merchants index when you click the link' do
    click_link "All Merchants"

    expect(current_path).to eq(admin_merchants_path)
  end

  it 'takes you to the admin invoices index when you click the link' do
    click_link "All Invoices"

    expect(current_path).to eq(admin_invoices_path)
  end

  it 'has the names of the top five customers' do
    within("#customer-#{@cust4.id}") do
      expect(page).to have_content(@cust4.first_name)
      expect(page).to have_content(@cust4.last_name)
    end

    within("#customer-#{@cust5.id}") do
      expect(page).to have_content(@cust5.first_name)
      expect(page).to have_content(@cust5.last_name)
    end

    within("#customer-#{@cust3.id}") do
      expect(page).to have_content(@cust3.first_name)
      expect(page).to have_content(@cust3.last_name)
    end

    within("#customer-#{@cust7.id}") do
      expect(page).to have_content(@cust7.first_name)
      expect(page).to have_content(@cust7.last_name)
    end

    within("#customer-#{@cust2.id}") do
      expect(page).to have_content(@cust2.first_name)
      expect(page).to have_content(@cust2.last_name)
    end
  end

  it 'shows incomplete invoices' do
    expect(page).to have_content("Incomplete Invoices")
    expect(page).to have_link("#{@invoice1.id}")
    expect(page).to have_link("#{@invoice2.id}")
    expect(page).to have_link("#{@invoice4.id}")
    expect(page).to have_link("#{@invoice6.id}")
  end

  it 'shows date of incomplete invoices' do
    expect(page).to have_content(@invoice1.created_at_formatted)
    expect(page).to have_content(@invoice2.created_at_formatted)
    expect(page).to have_content(@invoice4.created_at_formatted)
    expect(page).to have_content(@invoice6.created_at_formatted)
  end
end
