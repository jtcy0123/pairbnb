class User < ApplicationRecord
  include Clearance::User
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { in: 6..10 }
end
