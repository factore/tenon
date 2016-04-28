json.records do
  json.array!(@contacts) do |contact|
    json.extract!(contact, :id, :name, :email, :phone, :content, :sent_date, :user_ip, :user_agent, :referrer)
    json.display_link action_link(t('tenon.contacts.view_contact_details'), '#', 'eye', 'data-modal-target' => "#contact-#{contact.id}", 'data-modal-title' => t('tenon.contacts.contact_details'))
    json.read_link toggle_link(contact, 'read', toggle_read_contact_path(contact), ['folder-open-o', t('tenon.contacts.mark_as_unread')], ['folder-o', t('tenon.contacts.mark_as_read')])
    json.reply_link toggle_link(contact, 'replied', toggle_replied_contact_path(contact), ['check', t('tenon.contacts.mark_as_pending')], ['reply', t('tenon.contacts.mark_as_replied')])
    json.delete_link delete_link(contact)
  end
end

json.pagination do
  json.currentPage @contacts.current_page
  json.totalPages @contacts.total_pages
  json.totalEntries @contacts.total_entries
end
