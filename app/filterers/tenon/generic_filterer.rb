# Returns an <tt>ActiveRecord::Collection</tt> filtered based on the presence of
# params[:q] and the quick_search_fields passed into the initializer
#
# quick_search_fields should be an array of strings including table name
# eg. <tt>['title', 'description']</tt>
class Tenon::GenericFilterer < Tenon::BaseFilterer
  def initialize(scope, params, quick_search_fields)
    @quick_search_fields = quick_search_fields
    super(scope, params)
  end

  def filter
    quick_search if params[:q].present?
    scope
  end

  private

  def quick_search
    @quick_search_fields.each do |field_name|
      @scope = scope.where("#{field_name} ILIKE ?", "%#{params[:q]}%")
    end
  end
end
