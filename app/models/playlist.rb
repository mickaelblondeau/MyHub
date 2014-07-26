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
                    :styles => { :thumb => '138x69#', :banner => '710x280#' },
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
        :title,
        [:id, :title]
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
