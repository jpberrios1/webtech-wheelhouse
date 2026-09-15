class AddForeignKeysToDataBase < ActiveRecord::Migration[8.1]
  def change
    add_foreign_key :bikes, :customers
    add_foreign_key :bikes, :bike_models
    add_foreign_key :repairs, :bikes
    add_foreign_key :repairs, :employees, column: :mechanic_id
    add_foreign_key :repair_services, :repairs 
    add_foreign_key :repair_services, :standard_services
  end
end
