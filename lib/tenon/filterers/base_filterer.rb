# Creates a base for building Tenon::<Model>Filterer classes.
class Tenon::BaseFilterer
  attr_reader :scope
  attr_reader :params

  def initialize(scope, params)
    @scope = scope
    @params = params
  end

  def filter
    scope
  end
end
