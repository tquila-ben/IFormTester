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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110626100924) do

  create_table "iform_test_responses", :force => true do |t|
    t.integer  "iform_test_id"
    t.text     "header"
    t.text     "body"
    t.string   "request_via"
    t.datetime "sent_at"
    t.string   "sent_to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "iform_tests", :force => true do |t|
    t.integer  "iform_xml_feed_id"
    t.integer  "iform_xml_post_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "iform_xml_feeds", :force => true do |t|
    t.text     "body"
    t.text     "header"
    t.integer  "record_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "iform_xml_posts", :force => true do |t|
    t.text     "body"
    t.text     "header"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
