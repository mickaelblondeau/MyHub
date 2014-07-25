class UserView < ActiveRecord::Base
  validates :user_id, :video_id, presence: true
  belongs_to :user
  belongs_to :video

  before_create do
    if view_exist
      return false
    end
  end

  def view_exist
    UserView.where('user_id = ? AND video_id = ?', user_id, video_id).first
  end
end