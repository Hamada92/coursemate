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

ActiveRecord::Schema.define(version: 20170723141041) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text     "body"
    t.integer  "question_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_answers_on_question_id", using: :btree
    t.index ["user_id"], name: "index_answers_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id",     null: false
    t.integer  "question_id"
    t.integer  "group_id"
    t.integer  "answer_id"
    t.index ["answer_id"], name: "comments_answer_id", using: :btree
    t.index ["group_id"], name: "group_id_comments", using: :btree
    t.index ["question_id"], name: "question_id_comments", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "courses", primary_key: ["name", "university_domain"], force: :cascade do |t|
    t.text     "name",              null: false
    t.text     "university_domain", null: false
    t.datetime "created_at"
    t.index ["name", "university_domain"], name: "name_and_univresities_domain", using: :btree
    t.index ["university_domain"], name: "univresities_domain", using: :btree
  end

  create_table "group_enrollments", primary_key: ["user_id", "group_id"], force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "group_id",   null: false
    t.datetime "created_at"
    t.index ["group_id", "user_id"], name: "group_enrollments_group_id_user_id", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.text     "university_domain",            null: false
    t.text     "course_name",                  null: false
    t.integer  "creator_id"
    t.string   "status",            limit: 20
    t.integer  "seats"
    t.text     "location",                     null: false
    t.date     "day",                          null: false
    t.text     "title",                        null: false
    t.text     "description",                  null: false
    t.time     "start_time",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "end_time",                     null: false
    t.index ["course_name", "university_domain"], name: "group_university_course", using: :btree
    t.index ["creator_id"], name: "groups_creator_id", using: :btree
    t.index ["status"], name: "groups_status", using: :btree
    t.index ["university_domain"], name: "group_university", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "question_id"
    t.integer  "answer_id"
    t.index ["answer_id"], name: "answer_id_likes", using: :btree
    t.index ["question_id"], name: "question_id_likes", using: :btree
    t.index ["user_id", "answer_id"], name: "unique_answer_user", unique: true, using: :btree
    t.index ["user_id", "question_id"], name: "unique_question_user", unique: true, using: :btree
    t.index ["user_id"], name: "index_likes_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
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

  create_table "question_html_bodies", primary_key: "question_id", id: :integer, force: :cascade do |t|
    t.text "body"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.text     "university_domain", null: false
    t.text     "course_name",       null: false
    t.index ["course_name", "university_domain"], name: "question_university_course", using: :btree
    t.index ["university_domain"], name: "question_university", using: :btree
    t.index ["user_id"], name: "index_questions_on_user_id", using: :btree
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
  add_foreign_key "comments", "answers", name: "comments_answer_id_fkey"
  add_foreign_key "comments", "groups", name: "comments_group_id_fkey"
  add_foreign_key "comments", "questions", name: "comments_question_id_fkey"
  add_foreign_key "courses", "universities", column: "university_domain", primary_key: "domain", name: "courses_university_domain_fkey"
  add_foreign_key "group_enrollments", "groups", name: "group_enrollments_group_id_fkey"
  add_foreign_key "group_enrollments", "users", name: "group_enrollments_user_id_fkey"
  add_foreign_key "groups", "courses", column: "course_name", primary_key: "name", name: "groups_course_name_fkey", on_delete: :cascade
  add_foreign_key "groups", "universities", column: "university_domain", primary_key: "domain", name: "groups_university_domain_fkey"
  add_foreign_key "groups", "users", column: "creator_id", name: "groups_creator_id_fkey"
  add_foreign_key "likes", "answers", name: "likes_answer_id_fkey"
  add_foreign_key "likes", "questions", name: "likes_question_id_fkey"
  add_foreign_key "likes", "users"
  add_foreign_key "notifications", "answers", name: "notifications_answer_id_fkey"
  add_foreign_key "notifications", "comments", name: "notifications_comment_id_fkey"
  add_foreign_key "notifications", "likes", name: "notifications_like_id_fkey"
  add_foreign_key "notifications", "users", name: "notifications_user_id_fkey"
  add_foreign_key "question_html_bodies", "questions", name: "question_html_bodies_question_id_fkey"
  add_foreign_key "questions", "courses", column: "course_name", primary_key: "name", name: "questions_course_name_fkey", on_delete: :cascade
  add_foreign_key "questions", "universities", column: "university_domain", primary_key: "domain", name: "questions_university_domain_fkey"
  add_foreign_key "questions", "users"
  add_foreign_key "users", "universities", column: "university_domain", primary_key: "domain", name: "users_university_domain_fkey"

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
      groups.end_time,
      count(group_enrollments.group_id) AS num_attendees,
      (groups.seats - count(group_enrollments.group_id)) AS available_seats,
      universities.name AS university_name
     FROM (((groups
       LEFT JOIN group_enrollments ON ((group_enrollments.group_id = groups.id)))
       JOIN courses ON (((courses.name = groups.course_name) AND (courses.university_domain = groups.university_domain))))
       JOIN universities ON ((universities.domain = groups.university_domain)))
    GROUP BY groups.id, universities.name
    ORDER BY groups.id DESC;
  SQL

  create_view "user_with_scores",  sql_definition: <<-SQL
      SELECT users.id,
      users.email,
      users.encrypted_password,
      users.reset_password_token,
      users.reset_password_sent_at,
      users.remember_created_at,
      users.sign_in_count,
      users.current_sign_in_at,
      users.last_sign_in_at,
      users.current_sign_in_ip,
      users.last_sign_in_ip,
      users.created_at,
      users.updated_at,
      users.first_name,
      users.last_name,
      users.username,
      users.avatar_file_name,
      users.avatar_content_type,
      users.avatar_file_size,
      users.avatar_updated_at,
      users.avatar,
      users.avatar_temp,
      users.processing_avatar,
      users.crop_x,
      users.crop_y,
      users.crop_w,
      users.crop_h,
      users.privileges,
      users.confirmation_token,
      users.confirmed_at,
      users.confirmation_sent_at,
      users.unconfirmed_email,
      users.failed_attempts,
      users.unlock_token,
      users.locked_at,
      users.about_me,
      users.university_domain,
      COALESCE((COALESCE(t1.question_likes_score, (0)::bigint) + COALESCE(t2.answer_likes_score, (0)::bigint)), (0)::bigint) AS score
     FROM ((users
       LEFT JOIN ( SELECT questions.user_id,
              (count(*) * 5) AS question_likes_score
             FROM (likes
               JOIN questions ON ((likes.question_id = questions.id)))
            GROUP BY questions.user_id) t1 ON ((t1.user_id = users.id)))
       LEFT JOIN ( SELECT answers.user_id,
              (count(*) * 10) AS answer_likes_score
             FROM (likes
               JOIN answers ON ((likes.answer_id = answers.id)))
            GROUP BY answers.user_id) t2 ON ((t2.user_id = users.id)));
  SQL

  create_view "group_shows",  sql_definition: <<-SQL
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
      groups.end_time,
      universities.name AS university_name,
      ( SELECT (count(group_enrollments.group_id) = groups.seats) AS "full") AS "full",
      ARRAY( SELECT group_enrollments_1.user_id
             FROM group_enrollments group_enrollments_1
            WHERE (group_enrollments_1.group_id = groups.id)) AS attendees,
      user_with_scores.score AS user_score,
      user_with_scores.username
     FROM (((groups
       LEFT JOIN universities ON ((universities.domain = groups.university_domain)))
       LEFT JOIN group_enrollments ON ((group_enrollments.group_id = groups.id)))
       JOIN user_with_scores ON ((user_with_scores.id = groups.creator_id)))
    GROUP BY groups.id, universities.name, user_with_scores.score, user_with_scores.username
    ORDER BY groups.id DESC;
  SQL

  create_view "answer_shows",  sql_definition: <<-SQL
      SELECT answers.id,
      answers.body,
      answers.question_id,
      answers.user_id,
      answers.created_at,
      answers.updated_at,
      count(likes.answer_id) AS num_likes,
      ARRAY( SELECT likes_1.user_id
             FROM likes likes_1
            WHERE (likes_1.answer_id = answers.id)) AS likers,
      user_with_scores.score AS user_score
     FROM ((answers
       LEFT JOIN likes ON ((likes.answer_id = answers.id)))
       JOIN user_with_scores ON ((user_with_scores.id = answers.user_id)))
    GROUP BY answers.id, user_with_scores.score;
  SQL

  create_view "question_indices",  sql_definition: <<-SQL
      SELECT questions.id,
      questions.title,
      questions.body,
      questions.user_id,
      questions.created_at,
      questions.updated_at,
      questions.university_domain,
      questions.course_name,
      count(answers.question_id) AS num_answers,
      universities.name AS university_name,
      concat_ws(','::text, questions.course_name, questions.university_domain) AS course_url
     FROM (((questions
       LEFT JOIN answers ON ((answers.question_id = questions.id)))
       LEFT JOIN likes ON ((likes.question_id = questions.id)))
       JOIN universities ON ((universities.domain = questions.university_domain)))
    GROUP BY questions.id, universities.name
    ORDER BY questions.id DESC;
  SQL

  create_view "question_shows",  sql_definition: <<-SQL
      SELECT questions.id,
      questions.title,
      questions.body,
      questions.user_id,
      questions.created_at,
      questions.updated_at,
      questions.university_domain,
      questions.course_name,
      universities.name AS university_name,
      count(likes.question_id) AS num_likes,
      ARRAY( SELECT likes_1.user_id
             FROM likes likes_1
            WHERE (likes_1.question_id = questions.id)) AS likers,
      user_with_scores.score AS user_score,
      question_html_bodies.body AS html_body,
      concat_ws(','::text, questions.course_name, questions.university_domain) AS course_url
     FROM ((((questions
       LEFT JOIN universities ON ((universities.domain = questions.university_domain)))
       LEFT JOIN likes ON ((likes.question_id = questions.id)))
       LEFT JOIN question_html_bodies ON ((question_html_bodies.question_id = questions.id)))
       JOIN user_with_scores ON ((user_with_scores.id = questions.user_id)))
    GROUP BY questions.id, universities.name, user_with_scores.score, question_html_bodies.body
    ORDER BY questions.id DESC;
  SQL

end
