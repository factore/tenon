class CreateTenonResources < ActiveRecord::Migration
  def change
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
  end
end
