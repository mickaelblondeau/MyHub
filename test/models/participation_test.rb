require 'test_helper'

class ParticipationTest < ActiveSupport::TestCase
	test 'should not save without user id' do
		participation = Participation.new
		assert_not participation.save
	end
	
	test 'should save' do
		participation = Participation.new
		participation.user_id = 1
		assert participation.save
	end
	
	test 'get type' do
		assert participations(:video_participation).get_type == videos(:one)
		assert participations(:playlist_participation).get_type == playlists(:one)
	end
	
	test 'get type owner' do
		assert participations(:video_participation).get_type_owner == videos(:one).channel.user
		assert participations(:playlist_participation).get_type_owner == playlists(:one).user
	end
end
