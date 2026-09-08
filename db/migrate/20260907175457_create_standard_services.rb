class CreateStandardServices < ActiveRecord::Migration[8.1]
  def change
    create_table :standard_services do |t|
      t.string :name, null: false
      t.decimal :current_price, precision: 10, scale: 2, null: false
      t.timestamps
    end
    add_index :standard_services, :name, unique: true
  end
end
