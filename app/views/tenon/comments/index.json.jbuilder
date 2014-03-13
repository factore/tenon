json.records do
  json.array!(@comments) do |comment|
    json.extract!(comment, :id, :author, :author_email, :commentable_type, :commentable_id, :content)
    json.gravatar gravatar_for(comment)
    json.commentable_link link_to("#{comment.commentable_type} ##{comment.commentable_id}", comment.commentable, :target => "_")
    json.read_link action_link("Read", '#', 'eye', 'data-modal-target' => "#comment-#{comment.id}", 'data-modal-title' => 'Read Comment')
    if comment.approved
      json.approval_link action_link("Unapprove", unapprove_comment_path(comment), 'thumbs-down', class: 'unapprove')
    else
      json.approval_link action_link("Approve", approve_comment_path(comment), 'thumbs-up', class: 'approve')
    end
    json.delete_link delete_link(comment)
  end
end

json.pagination do
  json.currentPage @comments.current_page
  json.totalPages @comments.total_pages
  json.totalEntries @comments.total_entries
end