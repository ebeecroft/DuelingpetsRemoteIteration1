class CreateRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :registrations do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :country
      t.string :country_timezone
      t.date :birthday
      t.text :message
      t.integer :accounttype_id
      t.boolean :shared, default: false
      t.string :login_id
      t.string :vname
      t.datetime :registered_on

      t.timestamps
    end
  end
end
