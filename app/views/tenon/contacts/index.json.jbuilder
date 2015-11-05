json.records do
  json.array!(@contacts) do |contact|
    json.extract!(contact, :id, :name, :email, :phone, :content, :sent_date, :user_ip, :user_agent, :referrer)
    json.display_link action_link("View Contact Details", '#', 'eye', 'data-modal-target' => "#contact-#{contact.id}", 'data-modal-title' => 'Contact Details')
    json.read_link toggle_link(contact, 'read', toggle_read_contact_path(contact), ['folder-open-o', 'Mark as Unread'], ['folder-o', 'Mark as Read'])
    json.reply_link toggle_link(contact, 'replied', toggle_replied_contact_path(contact), ['check', 'Mark as Pending'], ['reply', 'Mark as Replied'])
    json.delete_path contact_path(contact)
    json.update_path contact_path(contact)
    json.is_read false
  end
end

json.pagination do
  json.currentPage @contacts.current_page
  json.totalPages @contacts.total_pages
  json.totalEntries @contacts.total_entries
end
