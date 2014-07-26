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
  has_attached_file :avatar,
                    :storage => :ftp,
                    :styles => { :thumb => '138x69#' },
                    :path => 'occuli/public/images/:class/:attachment/:style/:id.:extension',
                    :url => ':class/:attachment/:style/:id.:extension',
                    :ftp_servers => [
                        {
                            :host     => Rails.configuration.ftp_host1,
                            :user     => Rails.configuration.ftp_login,
                            :password => Rails.configuration.ftp_password,
                            :passive  => true
                        },
                        {
                            :host     => Rails.configuration.ftp_host2,
                            :user     => Rails.configuration.ftp_login,
                            :password => Rails.configuration.ftp_password,
                            :passive  => true
                        }
                    ],
                    :default_url => '/images/:style/missing.png'
  validates_attachment :avatar, :presence => true,
                       :content_type => { :content_type => ['image/jpeg', 'image/gif', 'image/png', 'image/bmp'] },
                       :size => { :in => 0..100.kilobytes }

  def should_generate_new_friendly_id?
    new_record?
  end
end
