class CreateSkillLinks < ActiveRecord::Migration
  def change
    create_table :skill_links do |t|
      t.references :skillable, polymorphic: true, index: true
      t.references :skill

      t.timestamps null: false
    end

    add_index :skill_links, [:skillable_id, :skillable_type, :skill_id], unique: true, name: "index_skill_links_on_sk_able_id_and_sk_able_type_and_sk_id"
  end
end
