module Tenon
  class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable, :lockable and :timeoutable
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

    # Assets
    has_and_belongs_to_many :roles

    # After a user is created, always give them the role of Member
    after_create :apply_member_role

    # Mass create some is_whatev? convenience methods
    ['Admin', 'Super Admin', 'Contributor', 'Member'].each do |role|
      define_method("is_#{role.dehumanize}?".to_sym) { self.roles.include?(Role.find_by_title(role)) }
    end
    alias_method :member?, :is_member?

    def as_json(opts = {})
      super(opts.merge(:methods => [:is_admin?]))
    end

    def staff?
      is_super_admin? || is_admin? || is_contributor?
    end

    private

    def apply_member_role
      self.roles << Role.find_by_title('Member') if self.roles.blank?
    end
  end
end