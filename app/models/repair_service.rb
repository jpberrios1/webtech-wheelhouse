class RepairService < ApplicationRecord
    belongs_to :repair
    belongs_to :standard_service

    validates :charged_price, presence: true, numericality: { greater_than: 0}
end