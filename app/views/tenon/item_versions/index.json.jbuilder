json.records do
  json.partial! 'item_version', collection: @item_versions, as: :item_version
end

json.pagination do
  json.currentPage @item_versions.current_page
  json.totalPages @item_versions.total_pages
  json.totalEntries @item_versions.total_entries
end