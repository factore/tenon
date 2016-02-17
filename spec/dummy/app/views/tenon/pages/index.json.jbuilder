pages = sort_list(@pages, :list_order)

json.records do
  json.array!(pages) do |page|
    json.extract!(page, :title, :lft, :rgt, :to_param, :parent_id, :id, :list_order)
    json.updated_at page.updated_at.strftime('%B %e, %Y at %l:%m%p')
    json.updater page.updater.present? ? page.updater.email : 'Unknown User'
    json.edit_path edit_page_path(page)

    if page.published?
      json.view_link action_link("View on Site", page.path, "laptop")
    end

    json.subpage_link action_link("Create a Sub-Page", new_page_path(parent_id: page.id), "plus")
    json.edit_link edit_link(page)
    if page.key.blank?
      json.delete_link delete_link(page)
    else
      json.delete_link action_link("Required Page, Can't Delete", "#", "star")
    end
  end
end
