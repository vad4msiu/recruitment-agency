class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :title

      t.timestamps null: false
    end

    add_index :skills, :title, unique: true
  end
end
