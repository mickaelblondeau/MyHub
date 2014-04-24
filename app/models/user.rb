class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :playlist_users
  has_many :series, through: :playlist_users, source: :serie

  validates :user_name, presence: true

  extend FriendlyId
  friendly_id :user_name, use: :slugged
end
