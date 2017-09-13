class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.is_admin?
      can :manage, :all
    else
      can :manage, :Account
    end

    can :manage, User, :id == user.id
    can :read, Order, :user_id == user.id
  end
end
