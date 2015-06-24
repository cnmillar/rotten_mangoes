class User < ActiveRecord::Base
	has_many :reviews, dependent: :destroy
	has_secure_password

	validates :email, uniqueness: true

	before_destroy :email

  def full_name
    "#{firstname} #{lastname}"
  end

end
