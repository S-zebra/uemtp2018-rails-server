class Post < ApplicationRecord
  belongs_to :account
  has_many :location
  validates :text, :latitude, :longitude, presence: true
  validates :text, length: {maximum: 300}
  validates :latitude, numericality: {greater_than_or_equal_to: -90, less_than_or_equal_to: 90}
  validates :longitude, numericality: {greater_than_or_equal_to: -180, less_than_or_equal_to: 180}
end
