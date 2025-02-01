# frozen_string_literal: true

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

ActiveRecord::Schema[7.1].define(version: 20_240_329_080_225) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'movie_in_theaters', force: :cascade do |t|
    t.bigint 'movie_show_id'
    t.bigint 'theater_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['movie_show_id'], name: 'index_movie_in_theaters_on_movie_show_id'
    t.index ['theater_id'], name: 'index_movie_in_theaters_on_theater_id'
  end

  create_table 'movie_shows', force: :cascade do |t|
    t.string 'language'
    t.integer 'seat_count'
    t.time 'show_start_time'
    t.integer 'screen_no'
    t.bigint 'movie_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'show_end_time'
    t.jsonb 'seat_type_price', default: {}
    t.jsonb 'seat_type_count', default: {}
    t.bigint 'user_id'
    t.index ['movie_id'], name: 'index_movie_shows_on_movie_id'
    t.index ['user_id'], name: 'index_movie_shows_on_user_id'
  end

  create_table 'movies', force: :cascade do |t|
    t.string 'title'
    t.text 'stars'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id'
    t.string 'img_url'
    t.index ['user_id'], name: 'index_movies_on_user_id'
  end

  create_table 'roles', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'theaters', force: :cascade do |t|
    t.string 'name'
    t.string 'location'
    t.string 'city'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id'
    t.index ['user_id'], name: 'index_theaters_on_user_id'
  end

  create_table 'tickets', force: :cascade do |t|
    t.integer 'price'
    t.string 'transaction_id'
    t.string 'payment_mode'
    t.bigint 'user_id'
    t.bigint 'movie_show_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'seat_type', array: true
    t.string 'seat_number', array: true
    t.index ['movie_show_id'], name: 'index_tickets_on_movie_show_id'
    t.index ['user_id'], name: 'index_tickets_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.integer 'age'
    t.string 'phone_no'
    t.string 'password_digest'
    t.bigint 'role_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['role_id'], name: 'index_users_on_role_id'
  end

  add_foreign_key 'movie_in_theaters', 'movie_shows'
  add_foreign_key 'movie_in_theaters', 'theaters'
  add_foreign_key 'movie_shows', 'movies'
  add_foreign_key 'movie_shows', 'users'
  add_foreign_key 'movies', 'users'
  add_foreign_key 'theaters', 'users'
  add_foreign_key 'tickets', 'movie_shows'
  add_foreign_key 'tickets', 'users'
  add_foreign_key 'users', 'roles'
end
