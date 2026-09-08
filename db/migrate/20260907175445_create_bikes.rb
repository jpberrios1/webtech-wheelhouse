class CreateBikes < ActiveRecord::Migration[8.1]
  def change
    create_table :bikes do |t|
      t.bigint :customer_id, null: false
      t.bigint :bike_model_id, null: false
      t.string :serial_number, null: false
      t.timestamps
    end
    add_index :bikes, :serial_number, unique: true
  end
end
