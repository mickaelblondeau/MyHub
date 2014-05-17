class Playlist < ActiveRecord::Base
  validates :title, :description, presence: true
  has_many :participations, :dependent => :destroy
  has_many :users, through: :participations
  has_many :videos
  belongs_to :user
  has_many :playlist_categories, :dependent => :destroy
  has_many :categories, through: :playlist_categories
  has_many :comments, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  has_many :likes, :dependent => :destroy
  has_many :articles, :dependent => :destroy

  def owned(u)
    user == u
  end
end
