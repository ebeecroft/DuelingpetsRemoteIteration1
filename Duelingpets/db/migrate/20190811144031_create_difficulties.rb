class CreateDifficulties < ActiveRecord::Migration[5.2]
  def change
    create_table :difficulties do |t|
      t.string :name
      t.integer :pointdebt
      t.integer :pointloan
      t.integer :emeralddebt
      t.integer :emeraldloan
      t.datetime :created_on

      t.timestamps
    end
  end
end
