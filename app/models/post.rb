class Post < ApplicationRecord
  belongs_to :account
  has_many :location
  has_many :children, :class_name => "Post", :foreign_key => "post_id" #親投稿が消えても子投稿は消えなくてもいいはず
  belongs_to :parent, :class_name => "Post", :foreign_key => "post_id", :optional => true
  validates :text, :latitude, :longitude, presence: true
  validates :text, length: {maximum: 300}
  validates :latitude, numericality: {greater_than_or_equal_to: -90, less_than_or_equal_to: 90}
  validates :longitude, numericality: {greater_than_or_equal_to: -180, less_than_or_equal_to: 180}
end
