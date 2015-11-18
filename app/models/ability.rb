class Ability
  include CanCan::Ability

  def initialize(u)
    if u.is_super_admin?
      can :manage, :all
      can :publish, :all
      can :assign_roles, Tenon::User
    elsif u.is_admin?
      can :manage, :all
      can :publish, :all
      can :assign_roles, Tenon::User

      cannot :update, Tenon::User
      can([:update], Tenon::User) do |user|
        !user.is_super_admin?
      end
      can :create, Tenon::User
    elsif u.is_contributor?
      can([:update, :edit, :publish], Tenon::User) { |user| user == u }
      can :read, :all
      can :create, Tenon::Page
    else
      can :read, :all
    end
  end
end
