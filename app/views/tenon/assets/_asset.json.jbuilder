json.extract!(asset,
  :id, :display_name, :icon, :to_param, :human_size,
  :attachment_content_type, :edit_link, :delete_link,
  :crop_link, :download_link
)
json.style_urls asset.style_urls
json.json_style_urls asset.style_urls.to_json