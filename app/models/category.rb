require 'paperclip/storage/ftp'

class Category < ActiveRecord::Base
  has_many :video_categories
  has_many :videos, through: :video_categories
  has_many :playlist_categories
  has_many :playlists, through: :playlist_categories

  has_attached_file :icon,
                    :storage => :ftp,
                    :path => 'occuli/public/images/categories/:id/:style/:filename',
                    :url => 'categories/:id/:style/:filename',
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