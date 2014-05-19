class AddIconToSeries < ActiveRecord::Migration
  def change
    add_attachment :playlists, :icon
  end
end
