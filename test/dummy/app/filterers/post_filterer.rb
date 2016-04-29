class PostFilterer < Tenon::GenericFilterer #:nodoc:
  def filter
    @scope = gte('posts.publish_at', params[:start_date])
    @scope = lte('posts.publish_at', params[:end_date])
    @scope = reorder(params[:order_field], params[:order_direction])
    @scope = hide_unpublished if params[:hide_unpublished].present?
    @scope = check_published_state if params[:published].present?
    super
  end

  private

  def check_published_state
    if params[:published] == 'published'
      hide_unpublished
    elsif params[:published] == 'unpublished'
      hide_published
    else
      @scope
    end
  end

  def hide_unpublished
    @scope.where.not(publish_at: nil)
  end

  def hide_published
    @scope.where(publish_at: nil)
  end

  def allowed_order_fields
    ['publish_at']
  end
end
