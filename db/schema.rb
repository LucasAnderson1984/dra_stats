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

ActiveRecord::Schema.define(version: 20180105052136) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "dra_score_students", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "dra_score_id", null: false
    t.uuid "student_id", null: false
    t.date "score_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dra_score_id", "score_date", "student_id"], name: "dra_score_students_index"
    t.index ["dra_score_id"], name: "index_dra_score_students_on_dra_score_id"
    t.index ["student_id"], name: "index_dra_score_students_on_student_id"
  end

  create_table "dra_scores", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "rank"
    t.string "dra_level"
    t.index ["dra_level"], name: "index_dra_scores_on_dra_level", unique: true
    t.index ["rank"], name: "index_dra_scores_on_rank", unique: true
  end

  create_table "students", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "teacher_id", null: false
    t.bigint "student_id_number", null: false
    t.string "first_name", null: false
    t.string "middle_name"
    t.string "last_name", null: false
    t.date "date_of_birth"
    t.string "grade", null: false
    t.integer "is_active", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id_number"], name: "index_students_on_student_id_number", unique: true
    t.index ["teacher_id"], name: "index_students_on_teacher_id"
  end

  create_table "teachers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name", limit: 30, null: false
    t.string "last_name", limit: 30, null: false
    t.string "grade", limit: 15, null: false
    t.integer "is_active", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
