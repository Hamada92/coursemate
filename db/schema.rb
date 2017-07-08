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

ActiveRecord::Schema.define(version: 20170707163816) do

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
    t.text     "name",                          null: false
    t.text     "university_domain",             null: false
    t.datetime "created_at"
    t.integer  "num_groups",        default: 0
    t.integer  "num_questions",     default: 0
    t.index ["num_groups"], name: "num_groups_courses", using: :btree
    t.index ["num_questions"], name: "num_questions_courses", using: :btree
    t.index ["university_domain"], name: "univresities_domain", using: :btree
  end

  create_table "group_enrollments", primary_key: ["user_id", "group_id"], force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "group_id",   null: false
    t.datetime "created_at"
    t.index ["group_id", "user_id"], name: "group_enrollments_group_id_user_id", using: :btree
  end

  create_table "groups", id: :integer, default: -> { "nextval('groups_id_seq1'::regclass)" }, force: :cascade do |t|
    t.text     "university_domain",                        null: false
    t.text     "course_name",                              null: false
    t.integer  "creator_id"
    t.string   "status",            limit: 20
    t.integer  "seats"
    t.text     "location",                                 null: false
    t.date     "day",                                      null: false
    t.text     "title",                                    null: false
    t.text     "description",                              null: false
    t.time     "start_time",                               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "num_enrollments",              default: 0
    t.time     "end_time",                                 null: false
    t.index ["course_name", "university_domain"], name: "group_university_course", using: :btree
    t.index ["creator_id"], name: "groups_creator_id", using: :btree
    t.index ["num_enrollments"], name: "num_enrollments_groups", using: :btree
    t.index ["status"], name: "groups_status", using: :btree
    t.index ["university_domain"], name: "group_university", using: :btree
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

  create_table "notifications", id: :integer, default: -> { "nextval('notifications_id_seq1'::regclass)" }, force: :cascade do |t|
    t.integer "comment_id"
    t.integer "answer_id"
    t.integer "like_id"
    t.integer "user_id",                    null: false
    t.boolean "read",       default: false
    t.index ["answer_id"], name: "answer_id_notifications", using: :btree
    t.index ["comment_id"], name: "comment_id_notifications", using: :btree
    t.index ["like_id"], name: "like_id_notifications", using: :btree
    t.index ["user_id"], name: "user_id_notifications", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "num_likes",         default: 0
    t.integer  "num_answers",       default: 0
    t.text     "university_domain",             null: false
    t.text     "course_name",                   null: false
    t.index ["course_name", "university_domain"], name: "question_university_course", using: :btree
    t.index ["university_domain"], name: "question_university", using: :btree
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
    t.text    "name",                      null: false
    t.text    "country",                   null: false
    t.integer "num_groups",    default: 0
    t.integer "num_questions", default: 0
    t.index ["name", "country"], name: "universities_name_country_key", unique: true, using: :btree
    t.index ["num_groups"], name: "num_groups_universities", using: :btree
    t.index ["num_questions"], name: "num_questions_universities", using: :btree
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
  add_foreign_key "group_enrollments", "groups", name: "group_enrollments_group_id_fkey"
  add_foreign_key "group_enrollments", "users", name: "group_enrollments_user_id_fkey"
  add_foreign_key "questions", "courses", column: "course_name", primary_key: "name", name: "questions_course_name_fkey", on_delete: :cascade
  add_foreign_key "questions", "universities", column: "university_domain", primary_key: "domain", name: "questions_university_domain_fkey"

  create_view "group_indices",  sql_definition: <<-SQL
      SELECT groups.id,
      groups.university_domain,
      groups.course_name,
      groups.creator_id,
      groups.status,
      groups.seats,
      groups.location,
      groups.day,
      groups.title,
      groups.description,
      groups.start_time,
      groups.created_at,
      groups.updated_at,
      groups.num_enrollments,
      groups.end_time,
      count(group_enrollments.group_id) AS num_attendees,
      (groups.seats - count(group_enrollments.group_id)) AS available_seats,
      users.avatar AS user_avatar,
      users.username,
      universities.name AS university_name
     FROM ((((groups
       JOIN group_enrollments ON ((group_enrollments.group_id = groups.id)))
       JOIN users ON ((users.id = groups.creator_id)))
       JOIN courses ON (((courses.name = groups.course_name) AND (courses.university_domain = groups.university_domain))))
       JOIN universities ON ((universities.domain = groups.university_domain)))
    GROUP BY groups.id, users.avatar, users.username, universities.name
    ORDER BY groups.id DESC;
  SQL

end
