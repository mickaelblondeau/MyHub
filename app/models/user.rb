class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  has_many :playlist_users, :dependent => :destroy
  has_many :series, through: :playlist_users, source: :serie, :dependent => :destroy
  has_many :likes, :dependent => :destroy
  has_many :channels, :dependent => :destroy

  validates :user_name, presence: true

  extend FriendlyId
  friendly_id :user_name, use: :slugged
end
