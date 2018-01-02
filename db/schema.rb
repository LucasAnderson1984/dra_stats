ActiveRecord::Schema.define(version: 20180101004601) do
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "teachers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name", limit: 30, null: false
    t.string "grade", limit: 15, null: false
    t.integer "is_active", default: 1, null: false
    t.string "last_name", limit: 30, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
