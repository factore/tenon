class PostFilterer < Tenon::GenericFilterer #:nodoc:
  def filter
    @scope = gte('posts.publish_at', params[:start_date])
    @scope = lte('posts.publish_at', params[:end_date])
    super
  end
end
