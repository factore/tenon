# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151117171100) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comment_subscribers", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comment_subscribers", ["commentable_id"], name: "index_comment_subscribers_on_commentable_id", using: :btree
  add_index "comment_subscribers", ["commentable_type"], name: "index_comment_subscribers_on_commentable_type", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "author"
    t.string   "author_url"
    t.string   "author_email"
    t.text     "content"
    t.string   "permalink"
    t.string   "user_ip"
    t.string   "user_agent"
    t.string   "referrer"
    t.integer  "commentable_id"
    t.boolean  "approved",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "commentable_type"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["created_at"], name: "index_comments_on_created_at", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.text     "content"
    t.string   "user_ip"
    t.string   "user_agent"
    t.string   "referrer"
    t.boolean  "read",       default: false, null: false
    t.boolean  "replied",    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["created_at"], name: "index_contacts_on_created_at", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "location"
    t.text     "description"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "publish_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galleries", force: :cascade do |t|
    t.string   "title"
    t.integer  "list_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_items", force: :cascade do |t|
    t.integer  "menu_id"
    t.string   "title",      limit: 255
    t.integer  "list_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "title"
    t.string   "slug"
    t.string   "path"
    t.integer  "list_order",        default: 999
    t.boolean  "show_in_menu",      default: true
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key"
    t.string   "seo_title"
    t.text     "seo_description"
    t.text     "seo_keywords"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "publish_at"
    t.boolean  "show_contact_form", default: false
  end

  add_index "pages", ["creator_id"], name: "index_pages_on_creator_id", using: :btree
  add_index "pages", ["parent_id"], name: "index_pages_on_parent_id", using: :btree
  add_index "pages", ["slug"], name: "index_pages_on_slug", using: :btree
  add_index "pages", ["updater_id"], name: "index_pages_on_updater_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "gallery_id"
    t.integer  "list_order"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["gallery_id"], name: "index_photos_on_gallery_id", using: :btree
  add_index "photos", ["list_order"], name: "index_photos_on_list_order", using: :btree

  create_table "post_categories", force: :cascade do |t|
    t.string   "title"
    t.integer  "list_order", default: 999
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_categories_posts", id: false, force: :cascade do |t|
    t.integer "post_category_id"
    t.integer "post_id"
  end

  add_index "post_categories_posts", ["post_category_id", "post_id"], name: "index_post_categories_posts_on_post_category_id_and_post_id", using: :btree
  add_index "post_categories_posts", ["post_id", "post_category_id"], name: "index_post_categories_posts_on_post_id_and_post_category_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "allow_comments",  default: true, null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.text     "excerpt"
    t.string   "seo_title"
    t.text     "seo_keywords"
    t.text     "seo_description"
    t.datetime "publish_at"
  end

  add_index "posts", ["created_at"], name: "index_posts_on_created_at", using: :btree
  add_index "posts", ["creator_id"], name: "index_posts_on_creator_id", using: :btree
  add_index "posts", ["updater_id"], name: "index_posts_on_updater_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "redirects", force: :cascade do |t|
    t.string   "in"
    t.string   "out"
    t.integer  "list_order", default: 0
    t.boolean  "active",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",        limit: 255, null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "tenon_assets", force: :cascade do |t|
    t.string   "title",                   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encoded_state",           limit: 255
    t.string   "output_url",              limit: 255
    t.string   "aspect_ratio",            limit: 255
    t.integer  "duration_in_ms"
    t.integer  "job_id"
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size"
    t.string   "attachment_file_name",    limit: 255
  end

  add_index "tenon_assets", ["created_at"], name: "index_assets_on_created_at", using: :btree
  add_index "tenon_assets", ["job_id"], name: "index_assets_on_job_id", using: :btree

  create_table "tenon_item_assets", force: :cascade do |t|
    t.integer  "asset_id"
    t.integer  "item_id"
    t.string   "item_type",  limit: 255
    t.string   "asset_name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tenon_item_assets", ["asset_id"], name: "index_item_assets_on_asset_id", using: :btree
  add_index "tenon_item_assets", ["item_id", "item_type"], name: "index_item_assets_on_item_id_and_item_type", using: :btree

  create_table "tenon_item_versions", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "item_type",  limit: 255
    t.binary   "attrs"
    t.string   "title",      limit: 255
    t.string   "save_type",  limit: 255
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tenon_item_versions", ["item_id", "item_type"], name: "index_tenon_item_versions_on_item_id_and_item_type", using: :btree

  create_table "tenon_role_assignments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "tenon_role_assignments", ["role_id"], name: "index_tenon_role_assignments_on_role_id", using: :btree
  add_index "tenon_role_assignments", ["user_id"], name: "index_tenon_role_assignments_on_user_id", using: :btree

  create_table "tenon_roles", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tenon_subscriber_group_members", force: :cascade do |t|
    t.integer  "subscriber_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tenon_subscriber_group_members", ["group_id"], name: "index_subscriber_group_members_on_group_id", using: :btree
  add_index "tenon_subscriber_group_members", ["subscriber_id"], name: "index_subscriber_group_members_on_subscriber_id", using: :btree

  create_table "tenon_subscriber_groups", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tenon_subscribers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tenon_tenon_callouts", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "icon",        limit: 255
    t.text     "content"
    t.string   "uri",         limit: 255
    t.string   "button_text", limit: 255
    t.integer  "list_order"
    t.boolean  "published"
    t.boolean  "new_window"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tenon_tenon_content_pieces", force: :cascade do |t|
    t.integer  "row_id"
    t.integer  "position"
    t.text     "content"
    t.string   "caption",         limit: 255
    t.string   "link_url",        limit: 255
    t.string   "embed_url",       limit: 255
    t.string   "piece_type",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "size",            limit: 255
    t.boolean  "show_caption",                default: false
    t.text     "embed_code"
    t.boolean  "stretch_to_fill",             default: false
  end

  add_index "tenon_tenon_content_pieces", ["row_id"], name: "index_tenon_content_pieces_on_row_id", using: :btree

  create_table "tenon_tenon_content_rows", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "item_type",   limit: 255
    t.string   "item_method", limit: 255
    t.integer  "list_order"
    t.string   "row_type",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tenon_tenon_content_rows", ["item_id"], name: "index_tenon_content_rows_on_item_id", using: :btree

  create_table "tenon_users", force: :cascade do |t|
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

  add_index "tenon_users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "tenon_users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
