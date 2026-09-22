class Repair < ApplicationRecord
    belongs_to :bike
    belongs_to :mechanic, class_name: 'Employee', optional: true
    has_many :repair_services, dependent: :destroy
    has_many :standard_services, through: :repair_services

    enum :state, {
        received: 'received',
        quoted: 'quoted',
        approved: 'approved',
        declined: 'declined',
        in_progress: 'in_progress',
        ready: 'ready',
        handed_back: 'handed_back'
    }

    scope :open, -> {where(handed_back_at: nil)}
    scope :overdue, -> {open.where('promised_on < ?', Date.current)}
    scope :newest_first, -> {order(created_at: :desc)}

    validate :dates_are_logical
    validate :state_bike_integrity


    def overdue?
        promised_on.present? && promised_on < Date.current && handed_back_at.nil?
    end

    def total
        repair_services.sum(:charged_price)
    end

    private 

    def dates_are_logical

        arrival_date = created_at.present? ? created_at.to_date : Date.current

        if promised_on.present? && promised_on < arrival_date
            errors.add(:promised_on, "cannot be set before the repair arrival day")
        end

        if  handed_back_at.present? && handed_back_at.to_date < arrival_date
            errors.add(:handed_back_at, "cannot be set before the repair arrival day")
        end
    end

    def state_bike_integrity
        post_answer_state = ["approved", "declined", "in_progress", "ready", "handed_back"]

        if post_answer_state.include?(state) && is_approved.nil?
            errors.add(:is_approved, "must be recorded once the customer gives an answer")
        end

        if state != 'handed_back' && handed_back_at.present?
            errors.add(:handed_back_at, "must remain empty until the bike is actually handed back")
        end
    end
end 