class PostFilterer < Tenon::GenericFilterer #:nodoc:
  def filter
    @scope = filter_start_date
    @scope = filter_end_date
    super
  end

  private

  def filter_start_date
    return scope unless params[:start_date].present?
    scope.where('publish_at >= ?', params[:start_date])
  end

  def filter_end_date
    return scope unless params[:end_date].present?
    scope.where('publish_at <= ?', params[:end_date])
  end
end
