class Playlist < ActiveRecord::Base
  validates :title, :description, presence: true
  has_many :participations
  has_many :users, through: :participations
  has_many :videos
  belongs_to :user

  def owned(u)
    user == u
  end
end
