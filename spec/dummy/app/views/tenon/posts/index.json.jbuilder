json.records do
  json.partial! 'post', collection: @posts, as: :post
end

json.pagination do
  json.currentPage @posts.current_page
  json.totalPages @posts.total_pages
  json.totalEntries @posts.total_entries
end
