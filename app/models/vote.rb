class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :playlist
  belongs_to :video

  def get_type
    if video
      video
    else
      playlist
    end
  end
end
