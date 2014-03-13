json.records do
  json.array!(@banners) do |banner|
    json.extract!(banner, :id, :title)
    json.edit_path edit_banner_path(banner)
    json.thumbnail image_tag banner.file.url(:_thumbnail)
    json.edit_link edit_link(banner)
    json.delete_link delete_link(banner)
  end
end

json.pagination do
  json.currentPage @banners.current_page
  json.totalPages @banners.total_pages
  json.totalEntries @banners.total_entries
end