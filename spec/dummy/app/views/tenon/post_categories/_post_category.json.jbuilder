json.extract!(post_category, :id, :title, :edit_path, :delete_link)
json.edit_link edit_link(post_category, data: {'modal-remote' => true, 'modal-title' => 'Edit Post Category'})
