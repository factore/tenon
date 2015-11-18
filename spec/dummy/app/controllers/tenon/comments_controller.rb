module Tenon
  class CommentsController < Tenon::ResourcesController
    before_filter :get_comment, only: [:approve, :unapprove, :destroy]

    def index
      respond_to do |format|
        format.html do
          @counts = {
            all: Comment.count,
            approved: Comment.approved.count,
            unapproved: Comment.unapproved.count
          }
        end
        format.json do
          @comments = Comment.all
          @comments = @comments.where(search_args) if params[:q]
          if %w(approved unapproved).include?(params[:type])
            @comments = @comments.send(params[:type])
          end
          @comments = @comments.paginate(per_page: 20, page: params[:page])
          @comments = PaginatingDecorator.decorate(@comments)
        end
      end
    end

    def toggle_approved
      respond_to do |format|
        if @comment.toggle_approved!
          format.json { render json: @comment.to_json }
          format.html { flash[:notice] = 'Comment approved.' and redirect_to comments_path }
        else
          format.json { render status: 500, nothing: true }
          format.html { flash[:warning] = 'Error approving comment.' and redirect_to comments_path }
        end
      end
    end

    private

    def get_comment
      @comment = Comment.find(params[:id])
    end

    def search_args
      [
        'author ILIKE :q OR author_url ILIKE :q OR author_email ILIKE :q OR content ILIKE :q OR user_ip ILIKE :q',
        { q: "%#{params[:q]}%" }
      ]
    end
  end
end
