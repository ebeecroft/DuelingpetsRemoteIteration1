class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :description
      t.string :ogg
      t.string :mp3
      t.string :adbanner
      t.string :admascot
      t.string :largeimage1
      t.string :largeimage2
      t.string :largeimage3
      t.string :smallimage1
      t.string :smallimage2
      t.string :smallimage3
      t.string :smallimage4
      t.string :smallimage5
      t.datetime :created_on
      t.datetime :reviewed_on
      t.datetime :updated_on
      t.integer :blogtype_id
      t.integer :bookgroup_id
      t.integer :blogviewer_id
      t.integer :user_id
      t.boolean :largeimage1purchased
      t.boolean :largeimage2purchased
      t.boolean :largeimage3purchased
      t.boolean :smallimage1purchased
      t.boolean :smallimage2purchased
      t.boolean :smallimage3purchased
      t.boolean :smallimage4purchased
      t.boolean :smallimage5purchased
      t.boolean :musicpurchased
      t.boolean :adbannerpurchased
      t.boolean :pointsreceived
      t.boolean :reviewed

      t.timestamps
    end
  end
end
