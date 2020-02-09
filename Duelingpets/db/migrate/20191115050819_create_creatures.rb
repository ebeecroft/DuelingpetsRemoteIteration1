class CreateCreatures < ActiveRecord::Migration[5.2]
  def change
    create_table :creatures do |t|
      t.string :name
      t.text :description
      t.string :image
      t.string :ogg
      t.string :mp3
      t.string :voiceogg
      t.string :voicemp3
      t.integer :level
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
      t.integer :lives
      t.integer :rarity
      t.boolean :unlimitedlives, default: false
      t.boolean :retiredpet, default: false
      t.boolean :starter, default: false
      t.integer :petworth
      t.integer :cost
      t.datetime :created_on
      t.datetime :updated_on
      t.datetime :reviewed_on
      t.integer :user_id
      t.integer :creaturetype_id
      t.boolean :pointsreceived, default: false
      t.boolean :reviewed, default: false

      t.timestamps
    end
  end
end
