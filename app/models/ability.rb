class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    end
  end
end
