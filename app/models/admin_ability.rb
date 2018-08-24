class AdminAbility
  include CanCan::Ability
  def initialize user
    if user.admin?
      can :manage, :all
    else
      can :manage, [Movie, Screening, Room]
    end
  end
end
