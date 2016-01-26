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

ActiveRecord::Schema.define(version: 20160126194219) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comment_subscribers", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["commentable_id"], name: "index_comment_subscribers_on_commentable_id", using: :btree
    t.index ["commentable_type"], name: "index_comment_subscribers_on_commentable_type", using: :btree
  end

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
    t.index ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
    t.index ["commentable_id"], name: "index_comments_on_post_id", using: :btree
    t.index ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
    t.index ["created_at"], name: "index_comments_on_created_at", using: :btree
  end

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
    t.index ["created_at"], name: "index_contacts_on_created_at", using: :btree
  end

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
    t.string   "title"
    t.integer  "list_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", force: :cascade do |t|
    t.string   "title"
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
    t.index ["creator_id"], name: "index_pages_on_creator_id", using: :btree
    t.index ["parent_id"], name: "index_pages_on_parent_id", using: :btree
    t.index ["slug"], name: "index_pages_on_slug", using: :btree
    t.index ["updater_id"], name: "index_pages_on_updater_id", using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "gallery_id"
    t.integer  "list_order"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["gallery_id"], name: "index_photos_on_gallery_id", using: :btree
    t.index ["list_order"], name: "index_photos_on_list_order", using: :btree
  end

  create_table "post_categories", force: :cascade do |t|
    t.string   "title"
    t.integer  "list_order", default: 999
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_categories_posts", id: false, force: :cascade do |t|
    t.integer "post_category_id"
    t.integer "post_id"
    t.index ["post_category_id", "post_id"], name: "index_post_categories_posts_on_post_category_id_and_post_id", using: :btree
    t.index ["post_id", "post_category_id"], name: "index_post_categories_posts_on_post_id_and_post_category_id", using: :btree
  end

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
    t.index ["created_at"], name: "index_posts_on_created_at", using: :btree
    t.index ["creator_id"], name: "index_posts_on_creator_id", using: :btree
    t.index ["updater_id"], name: "index_posts_on_updater_id", using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "redirects", force: :cascade do |t|
    t.string   "in"
    t.string   "out"
    t.integer  "list_order", default: 0
    t.boolean  "active",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role_assignments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_role_assignments_on_role_id", using: :btree
    t.index ["user_id"], name: "index_role_assignments_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree
  end

  create_table "tenon_assets", force: :cascade do |t|
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
    t.index ["created_at"], name: "index_assets_on_created_at", using: :btree
    t.index ["job_id"], name: "index_assets_on_job_id", using: :btree
  end

  create_table "tenon_item_assets", force: :cascade do |t|
    t.integer  "asset_id"
    t.integer  "item_id"
    t.string   "item_type"
    t.string   "asset_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["asset_id"], name: "index_item_assets_on_asset_id", using: :btree
    t.index ["item_id", "item_type"], name: "index_item_assets_on_item_id_and_item_type", using: :btree
  end

  create_table "tenon_item_versions", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "item_type"
    t.binary   "attrs"
    t.string   "title"
    t.string   "save_type"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["item_id", "item_type"], name: "index_tenon_item_versions_on_item_id_and_item_type", using: :btree
  end

  create_table "tenon_tenon_content_pieces", force: :cascade do |t|
    t.integer  "row_id"
    t.integer  "position"
    t.text     "content"
    t.string   "caption"
    t.string   "link_url"
    t.string   "embed_url"
    t.string   "piece_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "show_caption",    default: false
    t.text     "embed_code"
    t.boolean  "stretch_to_fill", default: false
    t.integer  "size"
    t.index ["row_id"], name: "index_tenon_content_pieces_on_row_id", using: :btree
  end

  create_table "tenon_tenon_content_rows", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "item_type"
    t.string   "item_method"
    t.integer  "list_order"
    t.string   "row_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["item_id"], name: "index_tenon_content_rows_on_item_id", using: :btree
  end

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
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
