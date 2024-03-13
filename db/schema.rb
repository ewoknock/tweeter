# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_03_13_172828) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tweet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tweet_id"], name: "index_bookmarks_on_tweet_id"
    t.index ["user_id", "tweet_id"], name: "index_bookmarks_on_user_id_and_tweet_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "following_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["following_user_id"], name: "index_follows_on_following_user_id"
    t.index ["user_id", "following_user_id"], name: "index_follows_on_user_id_and_following_user_id", unique: true
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tweet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tweet_id"], name: "index_likes_on_tweet_id"
    t.index ["user_id", "tweet_id"], name: "index_likes_on_user_id_and_tweet_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "tweets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0, null: false
    t.bigint "parent_tweet_id"
    t.integer "replies_count", default: 0, null: false
    t.index ["parent_tweet_id"], name: "index_tweets_on_parent_tweet_id"
    t.index ["user_id"], name: "index_tweets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "username"
    t.string "display_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "bookmarks", "tweets"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "follows", "users"
  add_foreign_key "follows", "users", column: "following_user_id"
  add_foreign_key "likes", "tweets"
  add_foreign_key "likes", "users"
  add_foreign_key "tweets", "tweets", column: "parent_tweet_id"
  add_foreign_key "tweets", "users"
end
