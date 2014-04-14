class CreateContacts < ActiveRecord::Migration
  def change
    create_table "tenon_contacts" do |t|
      t.string   "name"
      t.string   "phone"
      t.string   "email"
      t.text     "content"
      t.string   "user_ip"
      t.string   "user_agent"
      t.string   "referrer"
      t.integer  "commentable_id"
      t.boolean  "read",              default: false, null: false
      t.boolean  "replied",         default: false, null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "tenon_contacts", ["created_at"], name: "index_contacts_on_created_at", using: :btree
  end
end
