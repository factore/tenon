json.pagination do
  json.currentPage collection.current_page
  json.totalPages collection.total_pages
  json.totalEntries collection.total_entries
end