module Tenon
  module ItemVersionHelper
    def autosaving_form_for(obj, opts = {}, &blk)
      data = build_data(obj, opts)

      default_opts = {
        builder: Tenon::FormBuilder,
        data: data,
        validate: true
      }

      form_for(obj, default_opts.merge(opts), &blk)
    end

    def save_draft_link(obj)
      path = new_item_version_path(item_type: class_for(obj), item_id: obj.id)
      css_class = 'draft'
      data = {
        'modal-remote' => true,
        'modal-handler' => 'Tenon.features.NewItemVersionHandler',
        'modal-title' => 'Save Draft'
      }
      link_to path, class: css_class, data: data do
        content_tag(:i, 'cloud_queue', class: 'material-icon') +
        'Save Draft'
      end
    end

    def clear_draft_link
      path = url_for(version: nil)
      link_to 'Load Active Version', path, class: 'delete-link'
    end

    def load_draft_link(obj)
      path = item_versions_path(item_type: obj.class.to_s, item_id: obj.id)
      data = {
        'modal-remote' => true,
        'modal-title' => 'Load Draft',
        'modal-handler' => 'Tenon.features.ItemVersionIndexHandler'
      }
      link_to 'Load Draft', path, class: 'delete-link', data: data
    end

    private

    def class_for(obj)
      if obj.class < Draper::Decorator
        obj.object.class.to_s
      else
        obj.class.to_s
      end
    end

    def build_data(obj, opts)
      data = {
        'item-type' => class_for(obj),
        'item-id' => obj.id,
        'autosave' => !params[:version],
        'version-create-path' => item_versions_path,
        'protect-changes' => true
      }

      if opts[:data]
        data = data.merge(opts[:data])
        opts.delete(:data)
      end

      data
    end
  end
end
