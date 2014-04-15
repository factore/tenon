class AddContactFormFlagToPages < ActiveRecord::Migration
  def change
    add_column :tenon_pages, :show_contact_form, :boolean, default: false
  end
end
