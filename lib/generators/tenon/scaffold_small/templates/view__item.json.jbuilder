json.extract!(<%= singular_name %>, :id, :title, :edit_path, :delete_link)
json.edit_link edit_link(<%= singular_name %>, data: {'modal-remote' => true, 'modal-title' => 'Edit <%= singular_name.titleize %>'})
