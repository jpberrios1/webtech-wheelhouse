class Bike < ApplicationRecord
    belongs_to :customer
    belongs_to :bike_model
    has_many :repairs

end