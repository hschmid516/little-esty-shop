require 'rails_helper'

RSpec.describe 'Merchant Invoices Show page' do
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
    @item5 = create(:item, merchant: @merch2)
    @item6 = create(:item, merchant: @merch2)
    @invoice1 = create(:invoice, customer: @cust1)
    @invoice2 = create(:invoice, customer: @cust2)
    @invoice3 = create(:invoice, customer: @cust3)
    @invoice4 = create(:invoice, customer: @cust4)
    @invoice5 = create(:invoice, customer: @cust5)
    @invoice6 = create(:invoice, customer: @cust6)
    @invoice7 = create(:invoice, customer: @cust7)
    @invoice8 = create(:invoice, customer: @cust7)
    @ii1 = InvoiceItem.create(item: @item1, invoice: @invoice1, status: 1, quantity: 15, unit_price: 1000)
    @ii2 = InvoiceItem.create(item: @item2, invoice: @invoice1, status: 1, quantity: 9, unit_price: 4000)
    @ii3 = InvoiceItem.create(item: @item3, invoice: @invoice1, status: 1, quantity: 25, unit_price: 1000)
    @ii4 = InvoiceItem.create(item: @item4, invoice: @invoice1, status: 1, quantity: 25, unit_price: 1001)
    InvoiceItem.create(item: @item3, invoice: @invoice2, status: 1)
    InvoiceItem.create(item: @item1, invoice: @invoice2)
    InvoiceItem.create(item: @item1, invoice: @invoice3)
    InvoiceItem.create(item: @item1, invoice: @invoice4)
    InvoiceItem.create(item: @item1, invoice: @invoice5)
    InvoiceItem.create(item: @item4, invoice: @invoice6)
    InvoiceItem.create(item: @item5, invoice: @invoice7)
    InvoiceItem.create(item: @item6, invoice: @invoice8)
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
    @disc3 = @merch1.discounts.create(name: 'Mad deals', percentage: 0.75, threshold: 20)
    @disc1 = @merch1.discounts.create(name: 'Fall Special', percentage: 0.25, threshold: 10)
    @disc2 = @merch1.discounts.create(name: 'Super Saver', percentage: 0.50, threshold: 15)
    @disc4 = @merch2.discounts.create(name: 'Lame Deal', percentage: 0.05, threshold: 100)
    visit merchant_invoice_path(@merch1, @invoice1)
  end

  it 'shows information for specific id' do
    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice1.status)
    expect(page).to have_content(@invoice1.created_at_formatted)
    expect(page).to have_content("#{@cust1.first_name} #{@cust1.last_name}")
  end

  it 'Shows all items on the invoice' do
    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item2.name)
    expect(page).to have_content(@item3.name)
    expect(page).to have_content(@ii1.quantity)
    expect(page).to have_content(@ii2.quantity)
    expect(page).to have_content('$10.00')
    expect(page).to have_content('$40.00')
    expect(page).to have_content(@invoice1.item_status(@item1.id))
    expect(page).to have_content(@invoice1.item_status(@item2.id))

    expect(page).to_not have_content(@item4.name)
    expect(page).to_not have_content(@item5.name)
    expect(page).to_not have_content(@item6.name)
  end

  it 'shows total revenue' do
    expect(page).to have_content('Total Revenue: $760.00')
  end

  it 'has a select box for invoice status' do
    within("#table-#{@ii1.id}") do

      select 'packaged', from: 'invoice_item_status'
      click_button('Update Item Status')
    end

    @ii1.reload

    expect(current_path).to eq(merchant_invoice_path(@merch1, @invoice1))
    expect(@ii1.status).to eq('packaged')

    within("#table-#{@ii1.id}") do
      expect(find(:css, 'select#invoice_item_status').value ).to eq('packaged')
    end

    within("#table-#{@ii2.id}") do
      select 'pending', from: 'invoice_item_status'
      click_button('Update Item Status')
    end
    expect(page).to have_content("Invoice Item has updated sucessfully")

    @ii2.reload

    expect(current_path).to eq(merchant_invoice_path(@merch1, @invoice1))
    expect(@ii2.status).to eq('pending')

    within("#table-#{@ii2.id}") do
      expect(find(:css, 'select#invoice_item_status').value ).to eq('pending')
    end
  end

  it 'shows discounted revenue' do
    expect(page).to have_content('Total Discounted Revenue: $497.50')
  end

  it 'has link to discount if applicable' do
    within("#table-#{@ii1.id}") do
      @ii1.reload
      expect(page).to have_content("#{@ii1.discount * 100}%")
    end

    within("#table-#{@ii2.id}") do
      @ii2.reload
      expect(page).to_not have_content('Discount:')
    end

    within("#table-#{@ii3.id}") do
      @ii3.reload
      expect(page).to have_content("#{@ii3.discount * 100}%")
    end
  end
end
