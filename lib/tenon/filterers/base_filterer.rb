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

  private

  def eq(field, value)
    return scope unless value.present?
    scope.where("#{field} IN (?)", value)
  end

  def ilike(field, value)
    return scope unless value.present?
    scope.where("#{field} ILIKE ?", "%#{value}%")
  end

  def lt(field, value)
    return scope unless value.present?
    scope.where("#{field} < ?", value)
  end

  def gt(field, value)
    return scope unless value.present?
    scope.where("#{field} > ?", value)
  end

  def lte(field, value)
    return scope unless value.present?
    scope.where("#{field} <= ?", value)
  end

  def gte(field, value)
    return scope unless value.present?
    scope.where("#{field} >= ?", value)
  end

  def sort(field, direction)
    direction ||= 'asc' # Do this manually in case nil is passed in
    return scope unless field.in?(allowed_sort_fields)
    return scope unless direction.downcase.in?(['asc', 'desc'])
    scope.order("#{field} #{direction}")
  end

  def allowed_sort_fields
    []
  end
end
