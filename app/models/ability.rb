class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.id != nil
      if user.is_admin?
        can :manage, :all
      else
        can :create, Comment
        can :manage, Comment do |c|
          if(c.user_id == user.id)
            true
          else
            c.get_type_owner.id == user.id
          end
        end

        can :create, Channel
        can :index, Channel
        can :manage, Channel do |c|
          c.user_id == user.id
        end

        can :manage, Video do |v|
          v.channel.user_id == user.id
        end

        can :create, Playlist
        can :index, Playlist
        can :manage, Playlist do |p|
          p.user_id == user.id
        end

        can :manage, Participation do |p|
          if(p.playlist.user_id == user.id)
            true
          else
            p.get_type_owner.id == user.id
          end
        end

        can :create, Like
        can :manage, Like do |l|
          l.user_id == user.id
        end

        can :create, Vote
        can :manage, Vote do |v|
          v.user_id == user.id
        end

        can :manage, Article do |a|
          a.playlist.user.id == user.id
        end

        can :manage, Cooperation do |c|
          c.channel.user.id == user.id
        end

        can :manage, CooperationPermission do |c|
          c.cooperation.channel.user.id == user.id
        end

        can :manage, VideoCategory do |vc|
          vc.video.channel.user_id == user.id
        end

        can :manage, PlaylistCategory do |pc|
          pc.playlist.user_id == user.id
        end
      end
    end
  end
end
