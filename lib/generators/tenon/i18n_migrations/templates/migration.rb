class AddI18nFields<%= file_hash.capitalize %> < ActiveRecord::Migration
  def change
<% tables.each do |table, columns| -%>
<% columns.each do |column| -%>
<% languages.each do |language| -%>
<% klass = table.singularize.camelize.constantize -%>
<% unless klass.column_names.include?("#{column}_#{language}") -%>
<% if klass.columns_hash[column.to_s] -%>
    add_column :<%= table.gsub('/', '_') %>, :<%= column %>_<%= language %>, :<%= klass.columns_hash[column.to_s].type %>
<% else -%>
<% puts "Table #{table} has no column #{column}" -%>
<% end -%>
<% end -%>
<% end -%>
<% end -%>
<% end -%>
  end
end