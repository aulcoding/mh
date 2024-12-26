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

ActiveRecord::Schema[7.1].define(version: 2024_12_24_141824) do
  create_table "attendance_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "classroom_sessions", force: :cascade do |t|
    t.date "session_date"
    t.integer "year"
    t.integer "semester"
    t.integer "classroom_student_id", null: false
    t.integer "teacher_id", null: false
    t.integer "ziyadah_id"
    t.integer "attendance_status_id", null: false
    t.string "attendance_remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "murajaah_id"
    t.index ["attendance_status_id"], name: "index_classroom_sessions_on_attendance_status_id"
    t.index ["classroom_student_id"], name: "index_classroom_sessions_on_classroom_student_id"
    t.index ["teacher_id"], name: "index_classroom_sessions_on_teacher_id"
    t.index ["ziyadah_id"], name: "index_classroom_sessions_on_ziyadah_id"
  end

  create_table "classroom_students", force: :cascade do |t|
    t.integer "year"
    t.integer "semester"
    t.integer "classroom_id", null: false
    t.integer "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_classroom_students_on_classroom_id"
    t.index ["student_id"], name: "index_classroom_students_on_student_id"
  end

  create_table "classrooms", force: :cascade do |t|
    t.string "name"
    t.integer "gender_id", null: false
    t.integer "level_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gender_id"], name: "index_classrooms_on_gender_id"
    t.index ["level_id"], name: "index_classrooms_on_level_id"
  end

  create_table "genders", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "levels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manuscript_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manuscripts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_manuscript_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "nickname"
    t.integer "gender_id", null: false
    t.date "birthdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gender_id"], name: "index_students_on_gender_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.integer "gender_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gender_id"], name: "index_teachers_on_gender_id"
  end

  add_foreign_key "classroom_sessions", "attendance_statuses"
  add_foreign_key "classroom_sessions", "classroom_students"
  add_foreign_key "classroom_sessions", "manuscripts", column: "ziyadah_id"
  add_foreign_key "classroom_sessions", "teachers"
  add_foreign_key "classroom_students", "classrooms"
  add_foreign_key "classroom_students", "students"
  add_foreign_key "classrooms", "genders"
  add_foreign_key "classrooms", "levels"
  add_foreign_key "students", "genders"
  add_foreign_key "teachers", "genders"
end
