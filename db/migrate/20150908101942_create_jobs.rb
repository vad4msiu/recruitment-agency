class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title, null: false
      t.date :expired_at, null: false
      t.decimal :salary, precision: 8, scale: 2, null: false
      t.text :contacts, null: false

      t.timestamps null: false
    end
  end
end
