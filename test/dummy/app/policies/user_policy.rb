class UserPolicy < Tenon::ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.super_admin?
        scope.all
      elsif user.admin?
        scope.exclude_super_admins
      end
    end
  end
end
