class AddCommentOnSerieParticipation < ActiveRecord::Migration
  def change
    add_column :playlist_users, :comment, :text
  end
end
