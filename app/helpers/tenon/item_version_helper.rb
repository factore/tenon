module Tenon
  module ItemVersionHelper
    def autosaving_form_for(obj, opts = {}, &blk)
      data = build_data(obj, opts)

      default_opts = {
        builder: Tenon::FormBuilder,
        data: data
      }

      form_for(obj, default_opts.merge(opts), &blk)
    end

    def save_draft_button(obj)
      path = new_item_version_path(item_type: class_for(obj), item_id: obj.id)
      css_class = 'btn btn-primary btn-block draft'
      data = {
        'modal-remote' => true,
        'modal-handler' => 'Tenon.features.NewItemVersionHandler',
        'modal-title' => t('tenon.item_versions.save_draft')
      }
      link_to t('tenon.item_versions.save_draft'), path, class: css_class, data: data
    end

    def clear_draft_link
      path = url_for(version: nil)
      link_to t('tenon.item_versions.load_active_version'), path, class: 'delete-link'
    end

    def load_draft_link(obj)
      path = item_versions_path(item_type: obj.class.to_s, item_id: obj.id)
      data = {
        'modal-remote' => true,
        'modal-title' => t('tenon.item_versions.load_draft'),
        'modal-handler' => 'Tenon.features.ItemVersionIndexHandler'
      }
      link_to t('tenon.item_versions.load_draft'), path, class: 'delete-link', data: data
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
        'version-create-path' => item_versions_path
      }

      if opts[:data]
        data = data.merge(opts[:data])
        opts.delete(:data)
      end

      data
    end
  end
end
