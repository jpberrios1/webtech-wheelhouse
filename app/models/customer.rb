class Customer < ApplicationRecord
    has_many :bikes, dependent: :restrict_with_error
    has_many :repairs, through: :bikes

    validates :name, presence: true, format: {with: /\A[a-zA-ZáéíóúÁÉÍÓÚñÑ\s\.]+\z/, message: "only allows letters and spaces", allow_blank: true}
    validates :phone, presence: true, format: {with: /\A[\d\-]+\z/, message: "only allows numbers and dashes", allow_blank: true}

    scope :by_name, -> {order(:name)}
end
