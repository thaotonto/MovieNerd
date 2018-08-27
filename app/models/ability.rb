class Ability
  include CanCan::Ability
  def initialize user
    return unless user.present?
    can :manage, User, id: user.id
    can :read, Order, user_id: user.id
    can :destroy, Order, user_id: user.id
  end
end
