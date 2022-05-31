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

ActiveRecord::Schema.define(version: 2022_05_29_165751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.datetime "time"
    t.string "home_team"
    t.string "away_team"
    t.string "venue_name"
    t.integer "game_id"
  end

  create_table "pitchers", force: :cascade do |t|
    t.string "pitcher_name"
  end

  create_table "pitches", force: :cascade do |t|
    t.string "pitch_type_description"
    t.bigint "game_id"
    t.bigint "pitcher_id"
    t.string "pitch_hand"
    t.string "batter"
    t.string "bat_side"
    t.string "call_description"
    t.float "release_angle"
    t.float "release_speed"
    t.float "release_extension"
    t.float "trajectory_vertical_break"
    t.float "trajectory_zone_speed"
    t.integer "strike"
    t.integer "ball"
    t.integer "in_play"
    t.string "play_event_description"
    t.string "at_bat_inning"
    t.index ["game_id"], name: "index_pitches_on_game_id"
    t.index ["pitcher_id"], name: "index_pitches_on_pitcher_id"
  end

  add_foreign_key "pitches", "games"
  add_foreign_key "pitches", "pitchers"
end
