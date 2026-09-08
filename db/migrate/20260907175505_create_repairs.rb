class CreateRepairs < ActiveRecord::Migration[8.1]
  def change
    create_table :repairs do |t|
      t.bigint :bike_id, null: false
      t.bigint :mechanic_id
      t.string :state, null: false, default: 'received'
      t.date :promised_on
      t.datetime :handed_back_at
      t.boolean :is_approved
      t.timestamps
    end
  end
end
