json.extract!(redirect, :id, :in, :out, :active, :edit_path, :edit_link, :delete_link)

json.active_link toggle_link(redirect, 'active', toggle_active_redirect_path(redirect), ['eye', 'Active'], ['eye-slash', 'Not Aactive'])