class Listing < ApplicationRecord
  belongs_to :user
  validates :name, :location, :pax_num, :price, :city, presence: true
  acts_as_taggable
  mount_uploaders :photos, PhotoUploader
  scope :search_city, -> (search_term) { where("city LIKE ?", "%#{search_term}%")}
  scope :search_pax, -> (number) { where(pax_num: number..10)}
  scope :search_price, -> (price) { where(price: 0..price)}

  # def self.search_city(search_term)
  #   where("city LIKE ?", "%#{search_term}%")
  # end

end
