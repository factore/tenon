json.title item_version.title.blank? ? t('tenon.item_versions.no_title') : item_version.title
json.created_at item_version.created_at.strftime('%m/%d/%Y at %l:%M%p')
json.user_email item_version.user.try(:email)
if item_version.item
  json.load_link action_link(t('tenon.item_versions.view_draft'), polymorphic_path([:edit, item_version.item], version: item_version.id), 'reply')
else
  json.load_link action_link(t('tenon.item_versions.view_draft'), new_polymorphic_path(item_version.item_type.constantize, version: item_version.id), 'reply')
end
