<% collections = attributes.select{|a| a.name.match(/_id$/)}.map{|a| a.name.gsub(/_id$/, '')}.uniq -%>
class Tenon::<%= class_name.pluralize %>Controller < Tenon::ResourcesController
<% unless collections.blank? -%>
  before_filter :get_collections, :only => [:index, :edit, :update, :new, :create]
<% end -%>

<% unless collections.blank? -%>
  private
    def get_collections
<% collections.each do |c| -%>
      @<%= c.pluralize %> = <%= c.camelize %>.all
<% end -%>
    end
<% end -%>

    def resource_params
      params.require(:<%= singular_name %>).permit!
    end
end
