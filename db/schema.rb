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

ActiveRecord::Schema.define(version: 20170603181850) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text     "body"
    t.integer  "question_id"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "num_likes",   default: 0
    t.index ["question_id"], name: "index_answers_on_question_id", using: :btree
    t.index ["user_id"], name: "index_answers_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "courses", primary_key: ["name", "university_domain"], force: :cascade do |t|
    t.text "name",              null: false
    t.text "university_domain", null: false
    t.index ["university_domain"], name: "univresities_domain", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.text    "university_domain",            null: false
    t.text    "course_name",                  null: false
    t.integer "creator_id"
    t.string  "status",            limit: 20
    t.integer "seats"
    t.text    "location",                     null: false
    t.date    "day",                          null: false
    t.text    "title",                        null: false
    t.text    "description",                  null: false
    t.time    "start_time",                   null: false
    t.index ["creator_id"], name: "groups_creator_id", using: :btree
    t.index ["status"], name: "groups_status", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.string   "likeable_type"
    t.integer  "likeable_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id", using: :btree
    t.index ["user_id"], name: "index_likes_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "notifier_type"
    t.integer  "notifier_id"
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "read",          default: false
    t.string   "source_type"
    t.integer  "source_id"
    t.index ["notifier_type", "notifier_id"], name: "index_notifications_on_notifier_type_and_notifier_id", using: :btree
    t.index ["source_id"], name: "index_notifications_on_source_id", using: :btree
    t.index ["source_type"], name: "index_notifications_on_source_type", using: :btree
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "num_likes",   default: 0
    t.integer  "num_answers", default: 0
    t.index ["user_id"], name: "index_questions_on_user_id", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "tag_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_taggings_on_question_id", using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.string   "university"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "category"
    t.index ["name", "category", "university"], name: "index_tags_on_name_and_category_and_university", using: :btree
    t.index ["university", "category"], name: "index_tags_on_university_and_category", using: :btree
    t.index ["university"], name: "index_tags_on_university", using: :btree
  end

  create_table "universities", primary_key: "domain", id: :text, force: :cascade do |t|
    t.text "name",    null: false
    t.text "country", null: false
    t.index ["name", "country"], name: "universities_name_country_key", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                               null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score",                  default: 0
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "avatar"
    t.string   "avatar_temp"
    t.boolean  "processing_avatar"
    t.float    "crop_x"
    t.float    "crop_y"
    t.float    "crop_w"
    t.float    "crop_h"
    t.integer  "privileges",             default: 0
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.text     "about_me"
    t.text     "university_domain"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", using: :btree
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "courses", "universities", column: "university_domain", primary_key: "domain", name: "courses_university_domain_fkey"
  add_foreign_key "groups", "courses", column: "course_name", primary_key: "name", name: "groups_course_name_fkey"
  add_foreign_key "groups", "universities", column: "university_domain", primary_key: "domain", name: "groups_university_domain_fkey"
  add_foreign_key "groups", "users", column: "creator_id", name: "groups_creator_id_fkey"
  add_foreign_key "likes", "users"
  add_foreign_key "questions", "users"
  add_foreign_key "taggings", "questions"
  add_foreign_key "taggings", "tags"
  add_foreign_key "users", "universities", column: "university_domain", primary_key: "domain", name: "users_university_domain_fkey"
end
