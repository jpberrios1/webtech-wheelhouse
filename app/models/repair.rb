class Repair < ApplicationRecord
    belongs_to :bike
    belongs_to :mechanic, class_name: 'Employee', optional: true
    has_many :repair_services, dependent: :destroy, inverse_of: :repair
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
    
    accepts_nested_attributes_for :repair_services, allow_destroy: true, reject_if: :all_blank


    def overdue?
        promised_on.present? && promised_on < Date.current && handed_back_at.nil?
    end

    def total
        repair_services.sum(:charged_price)
    end

    has_rich_text :diagnosis

    has_many_attached :intake_photos do |attachable|
        attachable.variant :thumb, resize_to_limit: [200,200]
        attachable.variant :large, resize_to_limit: [800,800]
    end

    validate :intake_photos_must_be_valid



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

    def intake_photos_must_be_valid
        return unless intake_photos.attached?

        intake_photos.each do |photo|
            unless photo.content_type.in?(%w[image/png image/jpeg])
                errors.add(:intake_photos, "#{photo.filename} must be a PNG or a JPEG")
            end

            if photo.byte_size > 5.megabytes
                errors.add(:intake_photos, "#{photo.filename} must be smaller than 5 MB")
            end
        end
    end
end 