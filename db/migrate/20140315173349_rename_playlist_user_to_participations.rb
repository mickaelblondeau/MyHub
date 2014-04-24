class RenamePlaylistUserToParticipations < ActiveRecord::Migration
  def change
    rename_table :playlist_users, :participations
  end
end
