json.extract!(asset,
  :id, :display_name, :icon, :tile, :to_param, :human_size,
  :attachment_content_type, :edit_link, :delete_link, :edit_path,
  :path, :crop_link, :download_link
)
json.style_urls asset.style_urls
json.json_style_urls asset.style_urls.to_json
