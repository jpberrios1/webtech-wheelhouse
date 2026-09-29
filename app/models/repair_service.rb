class RepairService < ApplicationRecord
    belongs_to :repair, inverse_of: :repair_services
    belongs_to :standard_service

    validates :charged_price, presence: true, numericality: { greater_than: 0}
end