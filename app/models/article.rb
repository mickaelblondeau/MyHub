class Article < ActiveRecord::Base
  validates :content, :title, presence: true
  belongs_to :user
  belongs_to :playlist
end
