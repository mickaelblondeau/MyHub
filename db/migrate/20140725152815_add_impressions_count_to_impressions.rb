class AddImpressionsCountToImpressions < ActiveRecord::Migration
  def change
    add_column :impressions, :impressions_count, :integer
  end
end
