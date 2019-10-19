class CreateUserupgrades < ActiveRecord::Migration[5.2]
  def change
    create_table :userupgrades do |t|
      t.integer :pouchbase
      t.integer :pouchinc
      t.integer :pouchcost
      t.integer :pouchmax
      t.integer :emeraldbase
      t.integer :emeraldinc
      t.integer :emeraldcost
      t.integer :emeraldmax
      t.integer :ocbase
      t.integer :ocinc
      t.integer :occost
      t.integer :ocmax
      t.integer :blogbase
      t.integer :bloginc
      t.integer :blogcost
      t.integer :blogmax
      t.integer :dreyterriumbase
      t.integer :dreyterriuminc
      t.integer :dreyterriumcost
      t.integer :dreyterriummax

      t.timestamps
    end
  end
end
