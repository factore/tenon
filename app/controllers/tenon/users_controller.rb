class Tenon::UsersController < Tenon::ResourcesController
  before_filter :get_roles, :only => [:new, :edit, :update, :create]

  def index
    respond_to do |format|
      format.html
      format.json {
        if current_user.is_super_admin?
          @users = Tenon::User.all
        elsif current_user.is_admin?
          @users = Tenon::User.includes(:roles).where.not(tenon_roles: {title: 'Super Admin'})
        end

        @users = @users.where(search_args) unless params[:q].blank?
        @users = @users.paginate(per_page: 20, page: params[:page])
        @users = Tenon::PaginatingDecorator.new(@users)
      }
    end
  end

  private

  def get_roles
    @roles = Tenon::Role.all
  end

  def search_args
    ["email ILIKE ?", "%#{params[:q]}%"]
  end

  def resource_params
    params.require(:user).permit!
  end
end
