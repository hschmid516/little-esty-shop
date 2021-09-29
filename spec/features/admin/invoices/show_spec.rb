require 'rails_helper'

describe 'admin invoices show page' do
  before(:each) do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)
    @cust1 = create(:customer)
    @item1 = create(:item, merchant: @merch1, unit_price: 3000)
    @item2 = create(:item, merchant: @merch1, unit_price: 6000)
    @item3 = create(:item, merchant: @merch1, unit_price: 4500)
    @item4 = create(:item, merchant: @merch2, unit_price: 1000)
    @invoice1 = create(:invoice, customer: @cust1, status: 2)
    @ii1 = InvoiceItem.create(item: @item1, invoice: @invoice1, status: 1, quantity: 15, unit_price: 1000)
    @ii2 = InvoiceItem.create(item: @item2, invoice: @invoice1, status: 1, quantity: 9, unit_price: 2000)
    @ii3 = InvoiceItem.create(item: @item3, invoice: @invoice1, status: 1, quantity: 25, unit_price: 3000)
    @ii4 = InvoiceItem.create(item: @item4, invoice: @invoice1, status: 1, quantity: 100, unit_price: 4000)
    @disc3 = @merch1.discounts.create(name: 'Mad deals', percentage: 0.75, threshold: 20)
    @disc1 = @merch1.discounts.create(name: 'Fall Special', percentage: 0.25, threshold: 10)
    @disc2 = @merch1.discounts.create(name: 'Super Saver', percentage: 0.50, threshold: 15)
    @disc4 = @merch2.discounts.create(name: 'Lame Deal', percentage: 0.05, threshold: 100)

    visit admin_invoice_path(@invoice1)
  end

  it 'displays information related to invoice' do

    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice1.status)
    expect(page).to have_content(@invoice1.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content(@cust1.first_name)
    expect(page).to have_content(@cust1.last_name)
  end

  it 'displays all items on invoice' do
    within("#table-#{@ii1.id}") do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@ii1.quantity)
      expect(page).to have_content(@ii1.status)
      expect(page).to have_content(@ii1.unit_price.fdiv(100))
    end

    within("#table-#{@ii2.id}") do
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@ii2.quantity)
      expect(page).to have_content(@ii2.status)
      expect(page).to have_content(@ii2.unit_price.fdiv(100))
    end

    within("#table-#{@ii3.id}") do
      expect(page).to have_content(@item3.name)
      expect(page).to have_content(@ii3.quantity)
      expect(page).to have_content(@ii3.status)
      expect(page).to have_content(@ii3.unit_price.fdiv(100))
    end

    within("#table-#{@ii4.id}") do
      expect(page).to have_content(@item4.name)
      expect(page).to have_content(@ii4.quantity)
      expect(page).to have_content(@ii4.status)
      expect(page).to have_content(@ii4.unit_price.fdiv(100))
    end
  end

  it 'shows total revenue' do
    expect(page).to have_content("Total Revenue: $5,080.00")
  end

  it 'can update invoice status' do
    within("#invoice-#{@invoice1.id}-status") do
      select 'completed', from: :invoice_status
      click_button('Update Invoice Status')
    end

    @invoice1.reload

    expect(current_path).to eq(admin_invoice_path(@invoice1))

    within("#invoice-#{@invoice1.id}-status") do
      expect(find(:css, 'select#invoice_status').value ).to eq('completed')
    end

    within("#invoice-#{@invoice1.id}-status") do
      select 'cancelled', from: :invoice_status
      click_button('Update Invoice Status')
    end

    within("#invoice-#{@invoice1.id}-status") do
      expect(find(:css, 'select#invoice_status').value ).to eq('cancelled')
    end
  end

  it 'shows total discounted revenue' do
    expect(page).to have_content("Total Discounted Revenue: $4,242.50")
  end

  it 'updates invoice item discount field when set to completed' do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)
    @cust1 = create(:customer)
    @item1 = create(:item, merchant: @merch1, unit_price: 3000)
    @item2 = create(:item, merchant: @merch1, unit_price: 6000)
    @item3 = create(:item, merchant: @merch1, unit_price: 4500)
    @item4 = create(:item, merchant: @merch2, unit_price: 1000)
    @invoice1 = create(:invoice, customer: @cust1, status: 0)
    @ii1 = InvoiceItem.create(item: @item1, invoice: @invoice1, status: 1, quantity: 15, unit_price: 1000)
    @ii2 = InvoiceItem.create(item: @item2, invoice: @invoice1, status: 1, quantity: 9, unit_price: 2000)
    @ii3 = InvoiceItem.create(item: @item3, invoice: @invoice1, status: 1, quantity: 25, unit_price: 3000)
    @ii4 = InvoiceItem.create(item: @item4, invoice: @invoice1, status: 1, quantity: 100, unit_price: 4000)
    @disc3 = @merch1.discounts.create(name: 'Mad deals', percentage: 0.75, threshold: 20)
    @disc1 = @merch1.discounts.create(name: 'Fall Special', percentage: 0.25, threshold: 10)
    @disc2 = @merch1.discounts.create(name: 'Super Saver', percentage: 0.50, threshold: 15)
    @disc4 = @merch2.discounts.create(name: 'Lame Deal', percentage: 0.05, threshold: 100)
    visit admin_invoice_path(@invoice1)

    expect(@ii1.discount).to eq(nil)

    within("#invoice-#{@invoice1.id}-status") do
      select 'completed', from: :invoice_status
      click_button('Update Invoice Status')
    end

    @ii1.reload
    
    expect(@ii1.discount).to eq(0.5)
  end
end
