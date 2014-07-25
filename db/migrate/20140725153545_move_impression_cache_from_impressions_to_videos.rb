class MoveImpressionCacheFromImpressionsToVideos < ActiveRecord::Migration
  def change
    remove_column :impressions, :impressions_count
    add_column :videos, :impressions_count, :integer
  end
end
