module Tenon
  class UsersController < Tenon::ResourcesController
    before_filter :get_roles, only: [:new, :edit, :update, :create]

    def index
      respond_to do |format|
        format.html
        format.json do
          if current_user.is_super_admin?
            @users = Tenon::User.all
          elsif current_user.is_admin?
            @users = Tenon::User.exclude_super_admins
          end

          @users = @users.where(search_args) unless params[:q].blank?
          @users = @users.paginate(per_page: 20, page: params[:page])
          @users = Tenon::PaginatingDecorator.new(@users)
        end
      end
    end

    def update
      if params[:user][:password].blank?
        params[:user].delete('password')
        params[:user].delete('password_confirmation')
      end
      super
    end

    private

    def get_roles
      @roles = Tenon::Role.all
    end

    def search_args
      ['email ILIKE ?', "%#{params[:q]}%"]
    end

    def resource_params
      if current_user.is_admin? || current_user.is_super_admin?
        cleaned_role_ids(params.require(:user).permit!)
      else
        untrusted_params
      end
    end

    def cleaned_role_ids(rp)
      sa_role = Tenon::Role.find_by_title('Super Admin')
      if sa_role && rp[:role_ids] && !current_user.is_super_admin?
        rp[:role_ids].delete(sa_role.id.to_s)
      end
      rp
    end

    def untrusted_params
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation
      )
    end
  end
end
