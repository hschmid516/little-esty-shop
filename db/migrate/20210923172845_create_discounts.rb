class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.string :name
      t.float :percentage
      t.integer :threshold
      t.references :merchant, foreign_key: true
    end
  end
end
