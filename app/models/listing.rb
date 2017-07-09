class Listing < ApplicationRecord
  belongs_to :user
  validates :name, :location, :pax_num, :price, :city, presence: true
  acts_as_taggable

  scope :search_city, -> (search_term) { where("city LIKE ?", "%#{search_term}%")}


  # def self.search_city(search_term)
  #   where("city LIKE ?", "%#{search_term}%")
  # end

end
