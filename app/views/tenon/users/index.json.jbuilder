json.records do
  json.array!(@users) do |user|
    unless user.is_super_admin? && !current_user.is_super_admin?
      json.extract!(user, :id, :email)
      json.roles user.roles.map(&:title).to_sentence
      json.created_at user.created_at.strftime('%B %e, %Y')
      if user.last_sign_in_at
        json.last_login user.last_sign_in_at.strftime('%B %e, %Y')
      else
        json.last_login t('tenon.users.never')
      end

      unless user == current_user
        json.approval_link action_link(user.approved? ? t('tenon.users.unapprove') : t('tenon.common.approve'), approve_user_path(user), :icon => user.approved? ? "thumbdown" : "thumbup", :class => "approve", :confirm => user.approved? ? t('tenon.users.are_you_sure_you_want_to_unapprove') : t('tenon.users.are_you_sure_the_user_will_be_notified')) if can?(:edit, user)
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
