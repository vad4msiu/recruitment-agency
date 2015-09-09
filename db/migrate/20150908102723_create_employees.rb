class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name, null: false
      t.decimal :salary, precision: 8, scale: 2, null: false
      t.text :contacts, null: false
      t.string :status, null: false

      t.timestamps null: false
    end
  end
end
