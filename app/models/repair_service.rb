class RepairService < ApplicationRecord
    belongs_to :repair
    belongs_to :standard_service
end