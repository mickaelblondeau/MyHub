require 'paperclip/storage/ftp'

class Category < ActiveRecord::Base
  validates :label, :slug_label, presence: true
  has_many :videos, -> { order 'created_at DESC' }, through: :playlists
  has_many :playlist_categories
  has_many :playlists, through: :playlist_categories
  has_many :category_links
  has_many :category_links_childs, foreign_key: :parent_id, class_name: :CategoryLink
  has_many :parents, through: :category_links
  has_many :childs, through: :category_links_childs, source: :category
  has_attached_file :icon,
                    :storage => :ftp,
                    :styles => { :thumb => '143x72#', :banner => '710x280#' },
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
  attr_accessor :last_video

  def slug_candidates
    [
        :slug_label,
        [:slug_label, :id]
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

  def get_featured_videos
    Video.joins(:playlist => :categories).where(categories: { id: id }).limit(Rails.configuration.videos_per_page).order('videos.created_at DESC')
  end

  def trans_label
    I18n.t('categories.' + label)
  end

  def get_category_last_video
    v = videos.first
    if v
      self.last_video = v.created_at
    end
  end

  def self.sort_categories
    categories = Category.all
    categories.each do |category|
      category.get_category_last_video()
    end
    categories.sort_by {|l| -l.last_video.to_i}
  end
end