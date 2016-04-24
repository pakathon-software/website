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

ActiveRecord::Schema.define(version: 20160320132223) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "admins", force: true do |t|
    t.string   "username",         null: false
    t.string   "crypted_password", null: false
    t.string   "salt",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["username"], name: "index_admins_on_username", unique: true, using: :btree

  create_table "cities", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "email"
    t.string   "phone"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "eventbrite_page"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admin_id"
    t.hstore   "schedule"
    t.text     "hero_copy"
    t.string   "map_photo"
    t.string   "province_name"
    t.string   "postal_code"
    t.text     "team_description"
    t.string   "slug"
    t.string   "hero_photographer_name"
    t.string   "hero_photographer_page"
    t.string   "hero_photo"
    t.text     "hero_photo_url"
  end

  add_index "cities", ["slug"], name: "index_cities_on_slug", using: :btree

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.text     "event_image"
    t.datetime "event_date"
    t.time     "event_time"
    t.string   "event_name"
    t.text     "address_line_1"
    t.text     "postal_code"
    t.text     "event_description"
    t.text     "eventpage_link"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "venue_name"
  end

  add_index "events", ["city_id"], name: "index_events_on_city_id", using: :btree

  create_table "faqs", force: true do |t|
    t.text     "question"
    t.text     "answer"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "faqs", ["city_id"], name: "index_faqs_on_city_id", using: :btree

  create_table "galleries", force: true do |t|
    t.text     "image_1"
    t.text     "image_2"
    t.text     "image_3"
    t.text     "image_4"
    t.text     "link_to_gallery"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "galleries", ["city_id"], name: "index_galleries_on_city_id", using: :btree

  create_table "hackathons", force: true do |t|
    t.datetime "date_of_hackathon"
    t.string   "venue_name"
    t.string   "address_line_1"
    t.string   "postal_code"
    t.text     "eventbrite_link"
    t.text     "day_1_image"
    t.text     "day_1_description"
    t.text     "day_2_image"
    t.text     "day_2_description"
    t.text     "day_3_image"
    t.text     "day_3_description"
    t.text     "judging_criteria"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hackathons", ["city_id"], name: "index_hackathons_on_city_id", using: :btree

  create_table "logos", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.text     "project_name"
    t.text     "project_url"
    t.string   "names_of_team_members"
    t.text     "project_description"
    t.text     "project_video_url"
    t.text     "project_photo"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["city_id"], name: "index_projects_on_city_id", using: :btree

  create_table "resources", force: true do |t|
    t.string   "title"
    t.string   "series"
    t.string   "type_of_document"
    t.string   "twitter_canned_message"
    t.string   "facebook_canned_message"
    t.string   "link_to_muut_discussion"
    t.string   "link_to_document"
    t.string   "link_to_download"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admin_id"
    t.string   "email_course_banner"
    t.integer  "clicks"
  end

  add_index "resources", ["admin_id"], name: "index_resources_on_admin_id", using: :btree

  create_table "roles", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "avatar"
    t.string   "type_of_user"
    t.string   "twitter"
    t.string   "linkedin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
  end

end
