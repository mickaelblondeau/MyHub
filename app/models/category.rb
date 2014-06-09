require 'paperclip/storage/ftp'

class Category < ActiveRecord::Base
  has_many :video_categories
  has_many :videos, through: :video_categories
  has_many :playlist_categories
  has_many :playlists, through: :playlist_categories
  has_many :category_links
  has_many :category_links_childs, foreign_key: :parent_id, class_name: :CategoryLink
  has_many :parents, through: :category_links
  has_many :childs, through: :category_links_childs, source: :category

  has_attached_file :icon,
                    :storage => :ftp,
                    :styles => { :thumb => '100x100' },
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
                    ]
  validates_attachment :icon, :presence => true,
                       :content_type => { :content_type => ['image/jpeg', 'image/gif', 'image/png'] },
                       :size => { :in => 0..100.kilobytes }
end