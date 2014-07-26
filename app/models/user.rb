class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  has_many :playlist_users, :dependent => :destroy
  has_many :series, through: :playlist_users, source: :serie, :dependent => :destroy
  has_many :likes, :dependent => :destroy
  has_many :channels, :dependent => :destroy
  has_many :videos, through: :channels

  validates :user_name, presence: true

  extend FriendlyId
  friendly_id :user_name, use: :slugged

  def should_generate_new_friendly_id?
    new_record?
  end
end
