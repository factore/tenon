class AddI18nFields<%= file_hash %> < ActiveRecord::Migration
  def change
<% tables.each do |table, columns| -%>
<% columns.each do |column| -%>
<% languages.each do |language| -%>
<% klass = table.singularize.camelize.constantize -%>
<% unless klass.column_names.include?("#{column}_#{language}") -%>
    add_column :<%= table %>, :<%= column %>_<%= language %>, :<%= klass.columns_hash[column.to_s].type %>
<% end -%>
<% end -%>
<% end -%>
<% end -%>
  end 
end