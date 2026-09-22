class Bike < ApplicationRecord
    belongs_to :customer
    belongs_to :bike_model
    has_many :repairs, dependent: :destroy

    before_validation :normalize_serial_number

    validates :serial_number, presence: true, uniqueness: true

    scope :by_serial, -> {order(:serial_number)}

    private 
    
    def normalize_serial_number
        self.serial_number = serial_number.to_s.strip.upcase if serial_number.present?
    end

end