class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :place

  validates_presence_of :content
  validates_presence_of :score

  #hook/callback to place model's average rating everytime a review is saved
  after_save :calculate_average

  def calculate_average
    a = self.place.average_rating
    self.place.update_attributes(total_average: a)
  end
end
