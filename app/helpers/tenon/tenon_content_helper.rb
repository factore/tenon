module Tenon
  module TenonContentHelper
    def row_link(title, row_type, field, f)
      opts = {
        'data-association-insertion-node' => "##{field}-tenon-content",
        'data-association-insertion-method' => 'append',
        'data-searchable-title' => title.downcase,
        partial: 'tenon/tenon_content/row',
        render_options: {
          locals: {
            row_partial: "tenon/tenon_content/row_types/form/#{row_type.to_s.underscore}",
            field: field,
            title: title
          }
        },
        wrap_object: proc do |row|
          row.set_row_type(row_type)
          row.decorate
        end
      }
      link_to_add_association row_link_content(title, row_type), f, "#{field}_tenon_content_rows".to_sym, opts
    end

    def row_link_content(title, row_type)
      content = image_tag(
        "tenon/tenon-content/#{row_type}.png",
        class: 'tn-tc-library__image',
        id: row_type,
        data: { :'row-type' => row_type }
      )
      content + content_tag(:p, title, class: 'tn-tc-library__title')
    end

    def tenon_content_sizes
      links = []
      Tenon.config.breakpoints.front_end.each do |name, widths|
        links << link_to(name.to_s.titleize, '#', class: 'btn btn-white', data: { size: size_for_breakpoint(widths[:default]) })
      end
      last = Tenon.config.breakpoints.front_end.values.last
      links << link_to('Mobile', '#', class: 'btn btn-white', data: { size: 320, mobile: true })
      links.join('').html_safe
    end

    def size_for_breakpoint(breakpoint)
      content_cols = Tenon.config.grid.content_columns[:default]
      gutter_width = Tenon.config.grid.gutter
      columns = Tenon.config.grid.columns
      (((breakpoint + gutter_width) / columns.to_f) * content_cols) - gutter_width
    end
  end
end
