require 'test_helper'

class PlaylistTest < ActiveSupport::TestCase
  test 'should not save without title' do
    playlist = Playlist.new
    playlist.description = 'desc'
    playlist.icon = File.new('test/fixtures/test.gif')
    assert_not playlist.save
  end

  test 'should not save without description' do
    playlist = Playlist.new
    playlist.title = 'title'
    playlist.icon = File.new('test/fixtures/test.gif')
    assert_not playlist.save
  end

  test 'should not save without icon' do
    playlist = Playlist.new
    playlist.title = 'title'
    playlist.description = 'desc'
    assert_not playlist.save
  end

  test 'should not save with unvalid icon' do
    playlist = Playlist.new
    playlist.title = 'title'
    playlist.description = 'desc'
    playlist.icon = File.new('test/fixtures/playlists.yml')
    assert_not playlist.save
    playlist.icon = File.new('test/fixtures/bigfile.jpg')
    assert_not playlist.save
  end

  test 'should save' do
    playlist = Playlist.new
    playlist.title = 'title'
    playlist.description = 'desc'
    playlist.icon = File.new('test/fixtures/test.gif')
    assert playlist.save
  end
end
