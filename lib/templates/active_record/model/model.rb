class <%= class_name %> < ApplicationRecord # :nodoc:
  has_history
<% unless attributes.select {|a| a.name == 'list_order' }.empty? -%>
  include Tenon::Reorderable
  default_scope { order(:list_order) }
<% end -%>
<% attributes.select { |a| a.type.to_s == 'asset' }.each do |f| -%>
  has_asset :<%= f.name %>
<% end -%>
<% if attributes.any? { |a| a.name.to_s == 'publish_at' } -%>
  scope :published, -> { where('<%= table_name %>.publish_at < ?', Time.now) }
<% end -%>
<% attributes.select{ |a| a.type.to_s == 'content' }.each do |f| -%>
  tenon_content :<%= f.name %>
<% end -%>
<% attributes.select { |a| a.type.to_s == 'reference' }.each do |attribute| -%>
  belongs_to :<%= attribute.name %>
<% end -%>
<% attributes.select{|a| a.name.match(/_id$/)}.each do |attribute| -%>
  belongs_to :<%= attribute.name.gsub(/_id$/, '') %>
<% end -%>
end
