class User < ActiveRecord::Base
	has_many :reviews
	has_secure_password

	validates :email, uniqueness: true

  def full_name
    "#{firstname} #{lastname}"
  end

end
