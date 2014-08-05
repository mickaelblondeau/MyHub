class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.id != nil
      if user.is_admin?
        can :manage, :all
      else
        can :create, Channel
        can :index, Channel
        can :manage, Channel do |c|
          c.user_id == user.id
        end

        can :manage, Video do |v|
          v.channel.user_id == user.id && (v.playlist.user_id == user.id || CooperationPermission::user_can(0, user.id, v.playlist.id))
        end

        can :edit, Video do |v|
          v.channel.user_id == user.id
        end

        can :create, Playlist
        can :index, Playlist
        can :manage, Playlist do |p|
          p.user_id == user.id || CooperationPermission::user_can(2, user.id, p.id)
        end

        can :manage, Participation do |p|
          p.playlist.user_id == user.id || CooperationPermission::user_can(2, user.id, p.playlist.id)
        end

        can :manage, CooperationPermission do |c|
          c.playlist.user.id == user.id || CooperationPermission::user_can(2, user.id, c.playlist.id)
        end

        can :manage, PlaylistCategory do |pc|
          pc.playlist.user_id == user.id || CooperationPermission::user_can(2, user.id, pc.playlist.id)
        end

        can :create, Comment
        can :manage, Comment do |c|
          if c.user_id == user.id
            true
          else
            c.get_type_owner.id == user.id || (c.playlist && CooperationPermission::user_can(1, user.id, c.playlist.id))
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

        can :show, Message do |m|
          m.user_id == user.id || m.owner_id == user.id
        end

        can :manage, Message do |m|
          m.user_id == user.id || m.owner_id == user.id
        end
      end
    end
  end
end
