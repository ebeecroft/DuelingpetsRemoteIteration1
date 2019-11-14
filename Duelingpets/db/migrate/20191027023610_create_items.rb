class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.string :itemart
      t.integer :hp
      t.integer :atk
      t.integer :def
      t.integer :spd
      t.integer :fun
      t.integer :hunger
      t.integer :knowledge
      t.integer :durability
      t.integer :rarity
      t.boolean :starter
      t.boolean :equipable
      t.integer :cost
      t.datetime :created_on
      t.datetime :reviewed_on
      t.datetime :updated_on
      t.integer :user_id
      t.integer :itemtype_id
      t.boolean :reviewed

      t.timestamps
    end
  end
end
