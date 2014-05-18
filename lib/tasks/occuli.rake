namespace :occuli do
  task :update_votes => :environment do
    votes = Vote.where('weekly = ?', true)
    votes.each do |vote|
      vote.weekly = false
      vote.save
    end
  end
end