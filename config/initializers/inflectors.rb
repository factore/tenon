module ActiveSupport::Inflector
  # does the opposite of humanize.... mostly. Basically does a
  # space-substituting .underscore
  def dehumanize(the_string)
    result = the_string.to_s.dup
    result.downcase.gsub(/ +/, '_')
  end
end

class String
  def dehumanize
    ActiveSupport::Inflector.dehumanize(self)
  end
end
