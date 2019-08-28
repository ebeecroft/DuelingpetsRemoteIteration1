class CreateDragonhoards < ActiveRecord::Migration[5.2]
  def change
    create_table :dragonhoards do |t|
      t.string :name
      t.text :message
      t.datetime :created_on
      t.string :ogg
      t.string :mp3
      t.float :taxbase
      t.float :taxinc
      t.integer :colorschemepoints
      t.integer :colorschemecleanup
      t.integer :treasury
      t.integer :contestpoints
      t.integer :conversioncost
      t.integer :emeraldvalue
      t.float :emeraldrate
      t.integer :pointscreated
      t.integer :profit
      t.boolean :denholiday
      t.string :dragonimage
      t.integer :blogadbannercost
      t.integer :bloglargeimagecost
      t.integer :blogsmallimagecost
      t.integer :blogmusiccost
      t.integer :blogpoints
      t.integer :dreyterrium_start
      t.integer :newdreyterriumcapacity
      t.integer :dreyterrium_extracted
      t.integer :dreyterriumchange
      t.integer :dreyterriumbasepoints
      t.integer :dreyterriumcurrent_value

      t.timestamps
    end
  end
end
