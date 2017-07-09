class User < ApplicationRecord
  include Clearance::User
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { in: 6..10 }

  has_many :authentications, dependent: :destroy

  def self.create_with_auth_and_hash(authentication, auth_hash)
    name = auth_hash["extra"]["raw_info"]["name"].split(' ')
    user = self.create!(
      first_name: name[0],
      last_name: name[1..-1].join(' '),
      password: SecureRandom.hex(3),
      email: auth_hash["extra"]["raw_info"]["email"]
    )
    user.authentications << authentication
    return user
  end

  # grab fb_token to access Facebook for user data
  def fb_token
    x = self.authentications.find_by(provider: 'facebook')
    return x.token unless x.nil?
  end

end
