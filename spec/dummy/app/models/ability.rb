class Ability
  include CanCan::Ability

  def initialize(u)
    if u.is_super_admin?
      can :manage, :all
      can :publish, :all
      can :assign_roles, User
    elsif u.is_admin?
      can :manage, :all
      can :publish, :all
      can :assign_roles, User

      cannot :update, User
      can([:update], User) do |user|
        !user.is_super_admin?
      end
      can :create, User
    elsif u.is_contributor?
      can([:update, :edit, :publish], User) { |user| user == u }
      can :read, :all
      can :create, Page
    else
      can :read, :all
    end
  end
end
