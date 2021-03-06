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

ActiveRecord::Schema.define(version: 20140801194451) do

  create_table "categories", force: true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.string   "slug"
    t.string   "slug_label"
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", using: :btree

  create_table "category_lang", force: true do |t|
    t.integer "category_id"
    t.integer "language_id"
    t.string  "label"
  end

  add_index "category_lang", ["category_id"], name: "index_category_lang_on_category_id", using: :btree
  add_index "category_lang", ["language_id"], name: "index_category_lang_on_language_id", using: :btree

  create_table "category_lang_tables", force: true do |t|
    t.integer "category_id"
    t.integer "language_id"
    t.string  "label"
  end

  add_index "category_lang_tables", ["category_id"], name: "index_category_lang_tables_on_category_id", using: :btree
  add_index "category_lang_tables", ["language_id"], name: "index_category_lang_tables_on_language_id", using: :btree

  create_table "category_langs", force: true do |t|
    t.integer "category_id"
    t.integer "language_id"
    t.string  "label"
  end

  add_index "category_langs", ["category_id"], name: "index_category_langs_on_category_id", using: :btree
  add_index "category_langs", ["language_id"], name: "index_category_langs_on_language_id", using: :btree

  create_table "category_links", force: true do |t|
    t.integer  "category_id"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "category_links", ["category_id"], name: "index_category_links_on_category_id", using: :btree
  add_index "category_links", ["parent_id"], name: "index_category_links_on_parent_id", using: :btree

  create_table "channels", force: true do |t|
    t.string   "name"
    t.string   "api_id"
    t.boolean  "validated"
    t.string   "validation_key"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "slug"
    t.string   "video_type"
  end

  add_index "channels", ["api_id"], name: "index_channels_on_api_id", using: :btree
  add_index "channels", ["slug"], name: "index_channels_on_slug", using: :btree
  add_index "channels", ["user_id"], name: "index_channels_on_user_id", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "video_id"
    t.integer  "playlist_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["playlist_id"], name: "index_comments_on_playlist_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree
  add_index "comments", ["video_id"], name: "index_comments_on_video_id", using: :btree

  create_table "cooperation_permissions", force: true do |t|
    t.integer  "permission"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "playlist_id"
  end

  add_index "cooperation_permissions", ["permission"], name: "index_cooperation_permissions_on_permission", using: :btree
  add_index "cooperation_permissions", ["playlist_id"], name: "index_cooperation_permissions_on_playlist_id", using: :btree
  add_index "cooperation_permissions", ["user_id"], name: "index_cooperation_permissions_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "impressions", force: true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "languages", force: true do |t|
    t.string "label"
    t.string "code"
  end

  create_table "languages_tables", force: true do |t|
    t.string "label"
    t.string "code"
  end

  create_table "likes", force: true do |t|
    t.integer  "owner_id"
    t.integer  "user_id"
    t.integer  "playlist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["owner_id"], name: "index_likes_on_owner_id", using: :btree
  add_index "likes", ["playlist_id"], name: "index_likes_on_playlist_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "owner_id"
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "seen"
    t.string   "title"
    t.boolean  "owner_deleted"
    t.boolean  "user_deleted"
  end

  add_index "messages", ["owner_id"], name: "index_messages_on_owner_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "participations", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "playlist_id"
    t.text     "comment"
    t.integer  "video_id"
  end

  add_index "participations", ["playlist_id"], name: "index_participations_on_playlist_id", using: :btree
  add_index "participations", ["user_id"], name: "index_participations_on_user_id", using: :btree
  add_index "participations", ["video_id"], name: "index_participations_on_video_id", using: :btree

  create_table "playlist_categories", force: true do |t|
    t.integer  "playlist_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "playlist_categories", ["category_id"], name: "index_playlist_categories_on_category_id", using: :btree
  add_index "playlist_categories", ["playlist_id"], name: "index_playlist_categories_on_playlist_id", using: :btree

  create_table "playlists", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.string   "slug"
  end

  add_index "playlists", ["slug"], name: "index_playlists_on_slug", using: :btree
  add_index "playlists", ["user_id"], name: "index_playlists_on_user_id", using: :btree

  create_table "user_views", force: true do |t|
    t.integer  "user_id"
    t.integer  "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_views", ["user_id"], name: "index_user_views_on_user_id", using: :btree
  add_index "user_views", ["video_id"], name: "index_user_views_on_video_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.text     "description"
    t.boolean  "is_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_name"
    t.string   "slug"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree
  add_index "users", ["user_name"], name: "index_users_on_user_name", unique: true, using: :btree

  create_table "videos", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "api_id"
    t.integer  "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.integer  "playlist_id"
    t.boolean  "status"
    t.integer  "impressions_count"
  end

  create_table "votes", force: true do |t|
    t.boolean  "vote"
    t.integer  "user_id"
    t.integer  "playlist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "video_id"
    t.boolean  "weekly"
  end

  add_index "votes", ["playlist_id"], name: "index_votes_on_playlist_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree
  add_index "votes", ["video_id"], name: "index_votes_on_video_id", using: :btree

end
