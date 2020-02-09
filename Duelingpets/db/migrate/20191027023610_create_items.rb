class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.string :itemart
      t.integer :hp
      t.integer :atk
      t.integer :def
      t.integer :agility
      t.integer :strength
      t.integer :mp
      t.integer :matk
      t.integer :mdef
      t.integer :magi
      t.integer :mstr
      t.integer :hunger
      t.integer :thirst
      t.integer :fun
      t.integer :durability
      t.integer :rarity
      t.boolean :retireditem, default: false
      t.boolean :starter, default: false
      t.boolean :equipable, default: false
      t.integer :itemworth
      t.integer :cost
      t.datetime :created_on
      t.datetime :reviewed_on
      t.datetime :updated_on
      t.integer :user_id
      t.integer :itemtype_id
      t.boolean :pointsreceived, default: false
      t.boolean :reviewed, default: false

      t.timestamps
    end
  end
end
