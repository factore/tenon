json.records do
  json.array!(@events) do |event|
    json.extract!(event, :id, :title, :display_date, :location, :edit_path, :edit_link, :delete_link)

    if event.published? && main_app.respond_to?(:event_path)
      json.view_link action_link("View on Site", main_app.event_path(event), "laptop")
    end

  end
end

json.pagination do
  json.currentPage @events.current_page
  json.totalPages @events.total_pages
  json.totalEntries @events.total_entries
end
