class Like < ActiveRecord::Base
  belongs_to :owner, foreign_key: :owner_id, class_name: :User
  belongs_to :user
  belongs_to :playlist

  def get_type
    if playlist
      playlist
    else
      user
    end
  end
end