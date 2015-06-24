class Movie < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  has_many :reviews

	validates :title, 
		presence: true

	validates :director, 
		presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_future	

  scope :search_results, -> (title, director, max, min){ where("title LIKE ? OR director LIKE ? OR (runtime_in_minutes < ? AND runtime_in_minutes > ?)", title, director, max, min)}
  
  def review_average
    if reviews.size > 0 
      reviews.sum(:rating_out_of_ten)/reviews.size if reviews.size > 0
    end
  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end
  
end
