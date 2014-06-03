class Playlist < ActiveRecord::Base
  validates :title, :description, :icon, presence: true
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

  has_attached_file :icon,
                    :storage => :ftp,
                    :path => 'occuli/public/images/:class/:attachment/:id.:extension',
                    :url => ':class/:attachment/:id.:extension',
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
                    ]
  validates_attachment_content_type :icon, :content_type => /\Aimage\/.*\Z/
  validates_attachment_presence :icon
end
