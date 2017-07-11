class Reservation < ApplicationRecord
  validates :checkin, :checkout, :guest_num, presence: true
end
