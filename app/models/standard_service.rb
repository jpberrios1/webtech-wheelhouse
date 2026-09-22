class StandardService < ApplicationRecord
    has_many :repair_services, dependent: :restrict_with_error
    has_many :repairs, through: :repair_services

    validates :name, presence: true, uniqueness: true
    validates :current_price, presence: true, numericality: { greater_than: 0}

    scope :by_price, -> {order(:current_price)}
end 