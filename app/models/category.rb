require 'paperclip/storage/ftp'

class Category < ActiveRecord::Base
  validates :label, presence: true
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
                    :styles => { :thumb => '100x100', :rect_thumb => '200x100' },
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
                       :content_type => { :content_type => ['image/jpeg', 'image/gif', 'image/png', 'image/bmp'] },
                       :size => { :in => 0..100.kilobytes }
  extend FriendlyId
  friendly_id :slug_candidates, :use => :slugged

  def slug_candidates
    [
        :label,
        [:label, :id]
    ]
  end


  def save_with_slug
    if save
      self.slug = nil
      save
    else
      false
    end
  end
end