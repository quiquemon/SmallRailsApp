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

ActiveRecord::Schema.define(version: 0) do

  create_table "payment", primary_key: ["idPayment", "idTeam"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "idPayment",                                       null: false
    t.boolean "status",                                          null: false
    t.string  "transaction", limit: 45,                          null: false
    t.decimal "amount",                 precision: 15, scale: 2, null: false
    t.date    "completed",                                       null: false
    t.integer "idTeam",                                          null: false
    t.index ["idTeam"], name: "fk_Payment_Team1_idx", using: :btree
  end

  create_table "runnernumber", primary_key: "idRunnerNumber", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
  end

  create_table "team", primary_key: "idTeam", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name",         limit: 100, null: false
    t.date   "creationDate",             null: false
    t.string "code",         limit: 80
  end

  create_table "user", primary_key: "idUser", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",       limit: 100, null: false
    t.string  "lastname",   limit: 100, null: false
    t.date    "birthday",               null: false
    t.string  "email",      limit: 70,  null: false
    t.string  "password",               null: false
    t.boolean "newsletter",             null: false
    t.index ["email"], name: "email_UNIQUE", unique: true, using: :btree
  end

  create_table "userteam", primary_key: ["idUser", "idTeam"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "idUser",                    null: false
    t.integer "idTeam",                    null: false
    t.string  "serial",         limit: 45
    t.integer "idRunnerNumber"
    t.index ["idRunnerNumber"], name: "fk_UserTeam_RunnerNumber1_idx", using: :btree
    t.index ["idTeam"], name: "fk_User_has_Team_Team1_idx", using: :btree
    t.index ["idUser"], name: "fk_User_has_Team_User_idx", using: :btree
  end

  add_foreign_key "payment", "team", column: "idTeam", primary_key: "idTeam", name: "fk_Payment_Team1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "userteam", "runnernumber", column: "idRunnerNumber", primary_key: "idRunnerNumber", name: "fk_UserTeam_RunnerNumber1", on_update: :cascade, on_delete: :nullify
  add_foreign_key "userteam", "team", column: "idTeam", primary_key: "idTeam", name: "fk_User_has_Team_Team1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "userteam", "user", column: "idUser", primary_key: "idUser", name: "fk_User_has_Team_User", on_update: :cascade, on_delete: :cascade
end
