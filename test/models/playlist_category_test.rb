require 'test_helper'

class PlaylistCategoryTest < ActiveSupport::TestCase
  test 'should not save without category id' do
    playlist_category = PlaylistCategory.new
    playlist_category.playlist_id = 1
    assert_not playlist_category.save
  end

  test 'should not save without playlist id' do
    playlist_category = PlaylistCategory.new
    playlist_category.category_id = 1
    assert_not playlist_category.save
  end

  test 'should save' do
    playlist_category = PlaylistCategory.new
    playlist_category.category_id = 1
    playlist_category.playlist_id = 1
    assert playlist_category.save
  end
end
