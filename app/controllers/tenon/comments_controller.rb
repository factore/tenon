class Tenon::CommentsController < Tenon::ResourcesController
  before_filter :get_comment, :only => [:approve, :unapprove, :destroy]

  def index
    respond_to do |format|
      format.html {
        @counts = {
          :all => Tenon::Comment.count,
          :approved => Tenon::Comment.approved.count,
          :unapproved => Tenon::Comment.unapproved.count
        }
      }
      format.json {
        @comments = Tenon::Comment.all
        @comments = @comments.where(search_args) if params[:q]
        if %w{ approved unapproved }.include?(params[:type])
          @comments = @comments.send(params[:type])
        end
        @comments = @comments.paginate(:per_page => 20, :page => params[:page])
        @comments = Tenon::PaginatingDecorator.decorate(@comments)
      }
    end
  end

  def approve
    respond_to do |format|
      if @comment.approve!
        format.json { render json: @comment.to_json }
        format.html { flash[:notice] = 'Comment approved.' and redirect_to comments_path }
      else
        format.json { render :status => 500, :nothing => true }
        format.html { flash[:warning] = 'Error approving comment.' and redirect_to comments_path }
      end
    end
  end

  def unapprove
    respond_to do |format|
      if @comment.unapprove!
        format.json { render json: @comment.to_json }
        format.html { flash[:notice] = 'Comment unapproved.' and redirect_to comments_path }
      else
        format.json { render :status => 500, :nothing => true }
        format.html { flash[:warning] = 'Error unapproving comment.' and redirect_to comments_path }
      end
    end
  end

  private

  def get_comment
    @comment = Tenon::Comment.find(params[:id])
  end

  def search_args
    [
      'author ILIKE :q OR author_url ILIKE :q OR author_email ILIKE :q OR content ILIKE :q OR user_ip ILIKE :q',
      {q: "%#{params[:q]}%"}
    ]
  end
end
