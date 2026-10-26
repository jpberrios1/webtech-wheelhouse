class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  belongs_to :employee, optional: true

  enum :role, { counter: "counter", mechanic: "mechanic", owner: "owner"}
  validates :password, length: { minimum: 10, message: "must be at least 10 characters long"}, allow_nil: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
