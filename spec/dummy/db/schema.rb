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

ActiveRecord::Schema.define(version: 20140512163915) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "settings", force: true do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "tenon_assets", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encoded_state"
    t.string   "output_url"
    t.string   "aspect_ratio"
    t.integer  "duration_in_ms"
    t.integer  "job_id"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.string   "attachment_file_name"
  end

  add_index "tenon_assets", ["created_at"], name: "index_assets_on_created_at", using: :btree
  add_index "tenon_assets", ["job_id"], name: "index_assets_on_job_id", using: :btree

  create_table "tenon_banners", force: true do |t|
    t.string   "title"
    t.integer  "list_order", default: 999
    t.datetime "publish_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tenon_banners", ["list_order"], name: "index_banners_on_list_order", using: :btree

  create_table "tenon_comment_subscribers", force: true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tenon_comment_subscribers", ["commentable_id"], name: "index_comment_subscribers_on_commentable_id", using: :btree
  add_index "tenon_comment_subscribers", ["commentable_type"], name: "index_comment_subscribers_on_commentable_type", using: :btree

  create_table "tenon_comments", force: true do |t|
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

  add_index "tenon_comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "tenon_comments", ["commentable_id"], name: "index_comments_on_post_id", using: :btree
  add_index "tenon_comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "tenon_comments", ["created_at"], name: "index_comments_on_created_at", using: :btree

  create_table "tenon_contacts", force: true do |t|
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

  add_index "tenon_contacts", ["created_at"], name: "index_contacts_on_created_at", using: :btree

  create_table "tenon_delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0
    t.integer  "attempts",   default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "queue"
  end

  add_index "tenon_delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "tenon_dispatches", force: true do |t|
    t.string   "subject"
    t.text     "content"
    t.datetime "sent_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "queued_message_count"
    t.integer  "sent_message_count"
    t.integer  "failed_message_count"
    t.integer  "opened_message_count"
    t.text     "display_content"
  end

  add_index "tenon_dispatches", ["creator_id"], name: "index_dispatches_on_creator_id", using: :btree
  add_index "tenon_dispatches", ["updater_id"], name: "index_dispatches_on_updater_id", using: :btree

  create_table "tenon_events", force: true do |t|
    t.string   "title"
    t.string   "location"
    t.text     "description"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "publish_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tenon_galleries", force: true do |t|
    t.string   "title"
    t.integer  "list_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tenon_item_assets", force: true do |t|
    t.integer  "asset_id"
    t.integer  "item_id"
    t.string   "item_type"
    t.string   "asset_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tenon_item_assets", ["asset_id"], name: "index_item_assets_on_asset_id", using: :btree
  add_index "tenon_item_assets", ["item_id", "item_type"], name: "index_item_assets_on_item_id_and_item_type", using: :btree

  create_table "tenon_item_versions", force: true do |t|
    t.integer  "item_id"
    t.string   "item_type"
    t.binary   "attrs"
    t.string   "title"
    t.string   "save_type"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tenon_pages", force: true do |t|
    t.integer  "parent_id"
    t.string   "title"
    t.string   "slug"
    t.string   "path"
    t.string   "unique_key"
    t.text     "content"
    t.integer  "list_order",        default: 999
    t.boolean  "show_in_menu",      default: true
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.boolean  "published"
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

  add_index "tenon_pages", ["creator_id"], name: "index_pages_on_creator_id", using: :btree
  add_index "tenon_pages", ["parent_id"], name: "index_pages_on_parent_id", using: :btree
  add_index "tenon_pages", ["slug"], name: "index_pages_on_slug", using: :btree
  add_index "tenon_pages", ["updater_id"], name: "index_pages_on_updater_id", using: :btree

  create_table "tenon_photos", force: true do |t|
    t.integer  "gallery_id"
    t.integer  "list_order"
    t.string   "title"
    t.integer  "file_file_size"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tenon_photos", ["gallery_id"], name: "index_photos_on_gallery_id", using: :btree
  add_index "tenon_photos", ["list_order"], name: "index_photos_on_list_order", using: :btree

  create_table "tenon_post_categories", force: true do |t|
    t.string   "title"
    t.integer  "list_order", default: 999
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tenon_post_categories_posts", id: false, force: true do |t|
    t.integer "post_category_id"
    t.integer "post_id"
  end

  add_index "tenon_post_categories_posts", ["post_category_id", "post_id"], name: "index_post_categories_posts_on_post_category_id_and_post_id", using: :btree
  add_index "tenon_post_categories_posts", ["post_id", "post_category_id"], name: "index_post_categories_posts_on_post_id_and_post_category_id", using: :btree

  create_table "tenon_posts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "allow_comments",  default: true,  null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.boolean  "published",       default: false
    t.text     "excerpt"
    t.string   "seo_title"
    t.text     "seo_keywords"
    t.text     "seo_description"
  end

  add_index "tenon_posts", ["created_at"], name: "index_posts_on_created_at", using: :btree
  add_index "tenon_posts", ["creator_id"], name: "index_posts_on_creator_id", using: :btree
  add_index "tenon_posts", ["updater_id"], name: "index_posts_on_updater_id", using: :btree
  add_index "tenon_posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "tenon_role_assignments", force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "tenon_role_assignments", ["role_id"], name: "index_tenon_role_assignments_on_role_id", using: :btree
  add_index "tenon_role_assignments", ["user_id"], name: "index_tenon_role_assignments_on_user_id", using: :btree

  create_table "tenon_roles", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tenon_subscriber_group_members", force: true do |t|
    t.integer  "subscriber_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tenon_subscriber_group_members", ["group_id"], name: "index_subscriber_group_members_on_group_id", using: :btree
  add_index "tenon_subscriber_group_members", ["subscriber_id"], name: "index_subscriber_group_members_on_subscriber_id", using: :btree

  create_table "tenon_subscriber_groups", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tenon_subscribers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tenon_tenon_callouts", force: true do |t|
    t.string   "title"
    t.string   "icon"
    t.text     "content"
    t.string   "uri"
    t.string   "button_text"
    t.integer  "list_order"
    t.boolean  "published"
    t.boolean  "new_window"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tenon_tenon_content_pieces", force: true do |t|
    t.integer  "row_id"
    t.integer  "position"
    t.text     "content"
    t.string   "dimenstions"
    t.string   "caption"
    t.string   "link_url"
    t.string   "embed_url"
    t.string   "piece_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "size"
    t.boolean  "show_caption", default: false
    t.text     "embed_code"
  end

  add_index "tenon_tenon_content_pieces", ["row_id"], name: "index_tenon_content_pieces_on_row_id", using: :btree

  create_table "tenon_tenon_content_rows", force: true do |t|
    t.integer  "item_id"
    t.string   "item_type"
    t.string   "item_method"
    t.integer  "list_order"
    t.string   "row_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tenon_tenon_content_rows", ["item_id"], name: "index_tenon_content_rows_on_item_id", using: :btree

  create_table "tenon_users", force: true do |t|
    t.string   "email",                              default: "",    null: false
    t.string   "encrypted_password",     limit: 128, default: "",    null: false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved",                           default: false
    t.datetime "reset_password_sent_at"
  end

  add_index "tenon_users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "tenon_users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
