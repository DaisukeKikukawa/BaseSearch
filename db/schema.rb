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

ActiveRecord::Schema[7.1].define(version: 2024_06_05_045002) do
  create_table "action_text_rich_texts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "body", size: :long
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "articles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.string "content", null: false
    t.string "belongable_type", null: false
    t.bigint "belongable_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["belongable_type", "belongable_id"], name: "index_articles_on_belongable"
  end

  create_table "game_articles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.integer "article_type", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_articles_on_game_id"
  end

  create_table "games", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "game_started_at", null: false
    t.bigint "ground_id", null: false
    t.bigint "tournament_record_id", null: false
    t.bigint "home_team_id", null: false
    t.bigint "away_team_id", null: false
    t.integer "tag_type"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["away_team_id"], name: "index_games_on_away_team_id"
    t.index ["ground_id"], name: "index_games_on_ground_id"
    t.index ["home_team_id"], name: "index_games_on_home_team_id"
    t.index ["tournament_record_id"], name: "index_games_on_tournament_record_id"
  end

  create_table "grounds", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "link_url"
    t.string "administrative_organization"
    t.string "tel"
    t.string "address", null: false
    t.string "image"
    t.string "google_map_url"
    t.string "train_and_walk_access"
    t.string "car_access"
    t.string "bus_access"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.string "name", null: false
    t.string "kana", null: false
    t.integer "position", null: false
    t.integer "uniform_number"
    t.integer "handedness", null: false
    t.integer "handedness_bat", null: false
    t.string "alma_mater", null: false
    t.string "catchphrase"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "team_categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "page_path"
    t.bigint "team_category_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_category_id"], name: "index_teams_on_team_category_id"
  end

  create_table "tournament_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "tournament_id", null: false
    t.bigint "ground_id", null: false
    t.date "startd_at", null: false
    t.date "end_at", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ground_id"], name: "index_tournament_records_on_ground_id"
    t.index ["tournament_id"], name: "index_tournament_records_on_tournament_id"
  end

  create_table "tournaments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "game_articles", "games"
  add_foreign_key "games", "grounds"
  add_foreign_key "games", "teams", column: "away_team_id"
  add_foreign_key "games", "teams", column: "home_team_id"
  add_foreign_key "games", "tournament_records"
  add_foreign_key "players", "teams"
  add_foreign_key "teams", "team_categories"
  add_foreign_key "tournament_records", "grounds"
  add_foreign_key "tournament_records", "tournaments"
end
