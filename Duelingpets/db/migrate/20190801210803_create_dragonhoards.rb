class CreateDragonhoards < ActiveRecord::Migration[5.2]
  def change
    create_table :dragonhoards do |t|
      t.string :name
      t.text :message
      t.datetime :created_on
      t.string :ogg
      t.string :mp3
      t.float :taxbase, limit: 53
      t.float :taxinc, limit: 53
      t.integer :colorschemepoints
      t.integer :colorschemecleanup
      t.integer :treasury, default: 0
      t.integer :contestpoints, default: 0
      t.integer :conversioncost
      t.integer :emeraldvalue
      t.float :emeraldrate, limit: 53
      t.integer :pointscreated
      t.integer :profit, default: 0
      t.boolean :denholiday, default: false
      t.string :dragonimage
      t.integer :blogadbannercost
      t.integer :bloglargeimagecost
      t.integer :blogsmallimagecost
      t.integer :blogmusiccost
      t.integer :blogpoints
      t.integer :blogmascotpoints
      t.integer :dreyterrium_start
      t.integer :newdreyterriumcapacity
      t.integer :dreyterrium_extracted, default: 0
      t.integer :dreyterriumchange
      t.integer :dreyterriumbasepoints
      t.integer :dreyterriumcurrent_value

      t.timestamps
    end
  end
end
