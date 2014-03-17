module Tenon
  module TreeHelper
    def nested_li(objects, &block)
      # This code is a frightmare.  I didn't write it I swear.
      objects = objects.order(:lft) if objects.is_a? Class

      return '' if objects.size == 0

      output = %(<li class='top' data-record-id="#{objects.first.id}">\n<div class='item-content'>\n)
      path = [nil]

      objects.each_with_index do |o, i|
        if o.parent_id != path.last
          # We are on a new level, did we decend or ascend?
          if path.include?(o.parent_id)
            # Remove wrong wrong tailing paths elements
            while path.last != o.parent_id
              path.pop
              output << %(
</li>
</ul>)
            end

            if o.parent_id
              output << %(\n</li>\n<li data-record-id="#{o.id}" class="subpage">\n)
            else
              output << %(\n</li>\n<li data-record-id="#{o.id}" class="top">\n<div class="item-content">\n)
            end
          else
            path << o.parent_id
            output << %(\n<ul class="subpages">\n<li class="subpage" data-record-id="#{o.id}">\n)
          end
        elsif i != 0
          if o.parent_id
            output << %(\n</li>\n<li data-record-id="#{o.id}" class="subpage">\n)
          else
            output << %(\n</li>\n<li data-record-id="#{o.id}" class="top">\n<div class="item-content">\n)
          end
        end
        output << capture(o, path.size - 1, &block)
      end

      path.each do |p|
        if p
          output << %(
</li>
</ul>)
        else
          output << %(
</div>
</li>)
        end
      end

      output.html_safe
    end

    def sorted_nested_li(objects, order, &block)
      nested_li sort_list(objects, order), &block
    end

    def sort_list(objects, order)
      objects = objects.order(:lft) if objects.is_a? Class

     # Partition the results
      children_of = {}
      objects.each do |o|
        children_of[o.parent_id] ||= []
        children_of[o.parent_id] << o
      end

      # Sort each sub-list individually
      children_of.each_value do |children|
        children = children.sort_by(&order)
      end

      # Re-join them into a single list
      results = []
      recombine_lists(results, children_of, nil)

      results
    end

    def recombine_lists(results, children_of, parent_id)
      if children_of[parent_id]
        children_of[parent_id].each do |o|
          results << o
          recombine_lists(results, children_of, o.id)
        end
      end
    end
  end
end
