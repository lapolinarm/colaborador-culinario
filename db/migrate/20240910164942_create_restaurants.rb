class CreateRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurants do |t|
      t.integer :ruc
      t.string :commercial_name
      t.string :company_name
      t.string :phone
      t.string :mobile_phone
      t.string :address
      t.string :district
      t.string :province
      t.string :country
      t.text :reference
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
