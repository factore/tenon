class Hash
  def recursive_symbolize_keys!
    symbolize_keys!
    # symbolize each hash in .values
    values.each { |h| h.recursive_symbolize_keys! if h.is_a?(Hash) }
    # symbolize each hash inside an array in .values
    values.select { |v| v.is_a?(Array) }.flatten.each { |h| h.recursive_symbolize_keys! if h.is_a?(Hash) }
    self
  end

  def deep_reject_key!(key)
    keys.each { |k| delete(k) if k == key || self[k] == self[key] }

    values.each { |v| v.deep_reject_key!(key) if v.is_a? Hash }
    self
  end
end
