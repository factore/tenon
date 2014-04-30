module Tenon
  class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable, :lockable and :timeoutable
    devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

    # Roles
    has_many :role_assignments
    has_many :roles, through: :role_assignments
    has_many :posts

    # After a user is created, always give them the role of Member
    after_create :apply_member_role

    # Scope to exclude super admins
    scope :exclude_super_admins, lambda {
      includes(:roles)
      .where
      .not(tenon_roles: { title: 'Super Admin' })
      .references(:roles)
    }

    # Mass create some is_whatev? convenience methods
    ['Admin', 'Super Admin', 'Contributor', 'Member'].each do |role|
      define_method("is_#{role.dehumanize}?".to_sym) { roles.include?(Role.find_by_title(role)) }
    end
    alias_method :member?, :is_member?

    def as_json(opts = {})
      super(opts.merge(methods: [:is_admin?]))
    end

    def staff?
      is_super_admin? || is_admin? || is_contributor?
    end

    private

    def apply_member_role
      roles << Role.find_by_title('Member') if roles.blank?
    end

    def password_required?
      !persisted? || !password.blank? || !password_confirmation.blank?
    end
  end
end
