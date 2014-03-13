module Tenon
  module TenonContentHelper
    def row_link(title, row_type, field, f)
      opts = {
        'data-association-insertion-node' => "##{field}-tenon-content",
        'data-association-insertion-method' => 'append',
        'data-searchable-title' => title.downcase,
        :partial => 'tenon/tenon_content/row',
        :render_options => {
          :locals => {
            :row_partial => "tenon/tenon_content/row_types/form/#{row_type.to_s.underscore}",
            :field => field,
            :title => title
          }
        },
        :wrap_object => Proc.new { |row| row.set_row_type(row_type); row.decorate }
      }
      link_to_add_association row_link_content(title, row_type), f, "#{field}_tenon_content_rows".to_sym, opts
    end

    def row_link_content(title, row_type)
      link = image_tag("tenon/tenon-content/#{row_type}.png", :id => row_type, :data => { :'row-type' => row_type })
      link += content_tag(:p,"#{title}")
    end

    def tenon_content_sizes
      links = []
      Tenon.config.front_end[:breakpoints].each do |name, size|
        links << link_to(name.to_s.titleize, '#', :class => 'btn btn-default', :data => { :size => size_for_breakpoint(size) })
      end
      last = Tenon.config.front_end[:breakpoints].values.last
      links << link_to('Mobile', '#', :class => 'btn btn-default', :data => { :size => 320, :mobile => true })
      links.join('').html_safe
    end

    def size_for_breakpoint(breakpoint)
      content_cols = Tenon.config.front_end[:content_columns][:default]
      gutter_width = Tenon.config.front_end[:gutter]
      columns = Tenon.config.front_end[:columns]
      (((breakpoint + gutter_width) / columns.to_f) * content_cols) - gutter_width
    end
  end
end