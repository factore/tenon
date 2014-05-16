class <%= class_name %> < ActiveRecord::Base
  # Scopes, attachments, etc.
  has_history
<% unless attributes.select{|a| a.name == "list_order" }.empty? -%>
  include Tenon::Reorderable
  default_scope :order => '<%= table_name %>.list_order'
<% end -%>
<% attributes.select {|a| a.type.to_s == 'asset'}.each do |f| -%>
  has_asset :<%= f.name %>
<% end -%>

  # Validations

  # Relationships
<% attributes.select(&:reference?).each do |attribute| -%>
  belongs_to :<%= attribute.name %>
<% end -%>
<% attributes.select {|a| a.name.match(/_id$/)}.each do |attribute| -%>
  belongs_to :<%= attribute.name.gsub(/_id$/, '') %>
<% end -%>

  private
end
