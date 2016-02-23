class PostFilterer < Tenon::GenericFilterer #:nodoc:
  def filter
    @scope = gte('posts.publish_at', params[:start_date])
    @scope = lte('posts.publish_at', params[:end_date])
    @scope = sort(params[:sort_field], params[:sort_direction])
    super
  end

  private

  def allowed_sort_fields
    ['publish_at']
  end
end
