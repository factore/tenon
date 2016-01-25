json.records do
  json.array!(@users) do |user|
    unless user.is_super_admin? && !current_user.is_super_admin?
      json.extract!(user, :id)
      json.title user.email
      json.created_at user.created_at.strftime('%B %e, %Y')

      json.roles user.roles.map(&:title).to_sentence
      if user.last_sign_in_at
        json.last_login user.last_sign_in_at.strftime('%B %e, %Y')
      else
        json.last_login "Never"
      end

      unless user == current_user
        json.approval_link action_link(user.approved? ? "Unapprove" : "Approve", approve_user_path(user), :icon => user.approved? ? "thumbdown" : "thumbup", :class => "approve", :confirm => user.approved? ? "Are you sure you want to unapprove this user?" : "Are you sure? The user will be notified by email.") if can?(:edit, user)
      end

      json.edit_path edit_user_path(user)
      json.edit_link edit_link(user)
      json.delete_link delete_link(user)
    end
  end
end

json.pagination do
  json.currentPage @users.current_page
  json.totalPages @users.total_pages
  json.totalEntries @users.total_entries
end
