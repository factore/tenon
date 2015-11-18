json.records do
  json.array!(@galleries) do |gallery|
    json.extract!(gallery, :title, :to_param, :id, :created_at)
    json.edit_path edit_gallery_path(gallery)

    json.edit_link edit_link(gallery)
    json.delete_link delete_link(gallery)
  end
end

json.pagination do
  json.currentPage @galleries.current_page
  json.totalPages @galleries.total_pages
  json.totalEntries @galleries.total_entries
end
