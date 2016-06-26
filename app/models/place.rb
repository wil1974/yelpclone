class Place < ActiveRecord::Base
  belongs_to :user
  has_many  :reviews, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :phone
  validates_presence_of :address
  validates_presence_of :website
  validates_presence_of :user_id

  geocoded_by :address
  after_validation :geocode

# calculate average rating for the place
  def average_rating
    self.reviews.sum(:score) / reviews.size
  rescue  ZeroDivisionError
    0
  end

  def self.search(search)
    if search
      where(['name ILIKE ? or address ILIKE ?', "#{search}%", "#{search}%"])
    else
      all
    end
  end
end
