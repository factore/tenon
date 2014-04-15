json.records do
  json.array!(@comments) do |comment|
    json.extract!(comment, :id, :author, :author_email, :commentable_type, :commentable_id, :content)
    json.gravatar gravatar_for(comment)
    json.commentable_link link_to("#{comment.commentable_type} ##{comment.commentable_id}", comment.commentable, :target => "_")
    json.read_link action_link("Read", '#', 'eye', 'data-modal-target' => "#comment-#{comment.id}", 'data-modal-title' => 'Read Comment')
    json.approval_link toggle_link(comment, 'approved', toggle_approved_comment_path(comment), ['thumbs-up', 'This is true'], ['thumbs-down', 'This is false'])
    json.delete_link delete_link(comment)
  end
end

json.pagination do
  json.currentPage @comments.current_page
  json.totalPages @comments.total_pages
  json.totalEntries @comments.total_entries
end