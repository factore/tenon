module Tenon
  class ApplicationPolicy
    attr_reader :user, :record

    def initialize(user, record)
      @user = user
      @record = record
    end

    def index?
      user.admin? || user.super_admin? || user.contributor?
    end

    def show?
      scope.where(id: record.id).exists?
    end

    def create?
      user.admin? || user.super_admin? || user.contributor?
    end

    def new?
      create?
    end

    def update?
      user.admin? || user.super_admin? || user.contributor?
    end

    def edit?
      update?
    end

    def destroy?
      user.admin? || user.super_admin? || user.contributor?
    end

    def reorder?
      user.admin? || user.super_admin? || user.contributor?
    end

    def publish?
      user.admin? || user.super_admin?
    end

    def scope
      Pundit.policy_scope!(user, record.class)
    end

    class Scope
      attr_reader :user, :scope

      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      def resolve
        scope
      end
    end
  end
end
