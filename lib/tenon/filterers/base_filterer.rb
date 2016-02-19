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
end
