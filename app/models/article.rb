class Article < ActiveRecord::Base
  validates :content, :playlist, :title, presence: true
  belongs_to :user
  belongs_to :playlist
end
