json.records do
  json.array!(@contacts) do |contact|
    json.extract!(contact, :id, :name, :email, :phone, :content, :sent_date, :user_ip, :user_agent, :referrer)
    json.display_link action_link("View Contact Details", '#', 'eye', 'data-modal-target' => "#contact-#{contact.id}", 'data-modal-title' => 'Contact Details')
    json.read_link toggle_link(contact.read, toggle_read_contact_path(contact), ['folder-open-o', 'This is true'], ['folder-o', 'This is false'])
    json.reply_link toggle_link(contact.replied, toggle_reply_contact_path(contact), ['check', 'This is true'], ['reply', 'This is false'])
    json.delete_link delete_link(contact)
  end
end

json.pagination do
  json.currentPage @contacts.current_page
  json.totalPages @contacts.total_pages
  json.totalEntries @contacts.total_entries
end