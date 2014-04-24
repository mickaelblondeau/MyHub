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

ActiveRecord::Schema.define(version: 20140316163940) do

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "channel_id"
    t.integer  "playlist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["channel_id"], name: "index_articles_on_channel_id"
  add_index "articles", ["playlist_id"], name: "index_articles_on_playlist_id"
  add_index "articles", ["user_id"], name: "index_articles_on_user_id"

  create_table "channels", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "api_id"
    t.boolean  "validated"
    t.string   "validation_key"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "slug"
  end

  add_index "channels", ["api_id"], name: "index_channels_on_api_id"
  add_index "channels", ["slug"], name: "index_channels_on_slug"
  add_index "channels", ["user_id"], name: "index_channels_on_user_id"

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "channel_id"
    t.integer  "video_id"
    t.integer  "playlist_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["channel_id"], name: "index_comments_on_channel_id"
  add_index "comments", ["playlist_id"], name: "index_comments_on_playlist_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"
  add_index "comments", ["video_id"], name: "index_comments_on_video_id"

  create_table "cooperation_permissions", force: true do |t|
    t.integer  "permission_id"
    t.integer  "cooperation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cooperation_permissions", ["cooperation_id"], name: "index_cooperation_permissions_on_cooperation_id"
  add_index "cooperation_permissions", ["permission_id"], name: "index_cooperation_permissions_on_permission_id"

  create_table "cooperations", force: true do |t|
    t.integer  "user_id"
    t.integer  "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cooperations", ["channel_id"], name: "index_cooperations_on_channel_id"
  add_index "cooperations", ["user_id"], name: "index_cooperations_on_user_id"

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "likes", force: true do |t|
    t.integer  "owner_id"
    t.integer  "user_id"
    t.integer  "channel_id"
    t.integer  "video_id"
    t.integer  "playlist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["channel_id"], name: "index_likes_on_channel_id"
  add_index "likes", ["owner_id"], name: "index_likes_on_owner_id"
  add_index "likes", ["playlist_id"], name: "index_likes_on_playlist_id"
  add_index "likes", ["user_id"], name: "index_likes_on_user_id"
  add_index "likes", ["video_id"], name: "index_likes_on_video_id"

  create_table "participations", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "playlist_id"
    t.text     "comment"
    t.integer  "video_id"
  end

  add_index "participations", ["playlist_id"], name: "index_participations_on_playlist_id"
  add_index "participations", ["user_id"], name: "index_participations_on_user_id"
  add_index "participations", ["video_id"], name: "index_participations_on_video_id"

  create_table "permissions", force: true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "playlists", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "playlists", ["user_id"], name: "index_playlists_on_user_id"

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["slug"], name: "index_users_on_slug"

  create_table "videos", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "api_id"
    t.integer  "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.integer  "playlist_id"
  end

  add_index "videos", ["api_id"], name: "index_videos_on_api_id"
  add_index "videos", ["channel_id"], name: "index_videos_on_channel_id"
  add_index "videos", ["playlist_id"], name: "index_videos_on_playlist_id"

  create_table "votes", force: true do |t|
    t.boolean  "vote"
    t.integer  "user_id"
    t.integer  "video_id"
    t.integer  "playlist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["playlist_id"], name: "index_votes_on_playlist_id"
  add_index "votes", ["user_id"], name: "index_votes_on_user_id"
  add_index "votes", ["video_id"], name: "index_votes_on_video_id"

end
