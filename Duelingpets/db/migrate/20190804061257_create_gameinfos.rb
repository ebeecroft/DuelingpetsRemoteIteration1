class CreateGameinfos < ActiveRecord::Migration[5.2]
  def change
    create_table :gameinfos do |t|
      t.integer :difficulty_id
      t.boolean :lives_enabled
      t.boolean :ageing_enabled
      t.datetime :activated_on
      t.boolean :startgame
      t.boolean :gamecompleted
      t.integer :success
      t.integer :failure
      t.integer :user_id

      t.timestamps
    end
  end
end
