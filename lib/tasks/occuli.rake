namespace :occuli do
  task :update_votes => :environment do
    votes = Vote.where('weekly = ?', true)
    votes.each do |vote|
      vote.weekly = false
      vote.save
    end
  end

  task :update_videos => :environment do
    videos = Video.all
    videos.each do |v|
      v.update_meta
    end
  end
end