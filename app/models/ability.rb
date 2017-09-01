class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.is_admin?
      can :manage, :all
    else
      can :manage, :Account
    end
    can :read, ActiveAdmin::Page, name: 'Dashboard', namespace_name: :admin

    can :manage, User do |u|
      u.id == user.id
    end

    can :read, Order do |o|
      o.user_id == user.id
    end
  end
end
