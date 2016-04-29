class AddUsers < ActiveRecord::Migration[5.0]
  def change
    create_table "users", force: :cascade do |t|
      t.string   "email",                  limit: 255, default: "",    null: false
      t.string   "encrypted_password",     limit: 128, default: "",    null: false
      t.string   "reset_password_token",   limit: 255
      t.string   "remember_token",         limit: 255
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",                      default: 0
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip",     limit: 255
      t.string   "last_sign_in_ip",        limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "approved",                           default: false
      t.datetime "reset_password_sent_at"
    end

    add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
    add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

    create_table "roles", force: :cascade do |t|
      t.string   "title",      limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "role_assignments", force: :cascade do |t|
      t.integer "user_id"
      t.integer "role_id"
    end

    add_index "role_assignments", ["role_id"], name: "index_role_assignments_on_role_id", using: :btree
    add_index "role_assignments", ["user_id"], name: "index_role_assignments_on_user_id", using: :btree

  end
end
