class CreateColorschemes < ActiveRecord::Migration[5.2]
  def change
    create_table :colorschemes do |t|
      t.string :name
      t.string :colortype
      t.text :description
      t.datetime :created_on
      t.integer :user_id
      t.boolean :activated, default: false
      t.boolean :democolor, default: false
      t.string :backgroundcolor
      t.string :headercolor
      t.string :textcolor
      t.string :defaultbuttoncolor
      t.string :defaultbuttonbackgcolor
      t.string :editbuttoncolor
      t.string :editbuttonbackgcolor
      t.string :destroybuttoncolor
      t.string :destroybuttonbackgcolor
      t.string :submitbuttoncolor
      t.string :submitbuttonbackgcolor
      t.string :navigationcolor
      t.string :navigationlinkcolor
      t.string :navigationhovercolor
      t.string :navigationhoverbackgcolor
      t.string :onlinestatuscolor
      t.string :profilecolor
      t.string :profilevisitedcolor
      t.string :profilehovercolor
      t.string :profilehoverbackgcolor
      t.string :sessioncolor
      t.string :navlinkcolor
      t.string :navlinkhovercolor
      t.string :navlinkhoverbackgcolor
      t.string :explanationborder
      t.string :explanationbackgcolor
      t.string :explanheadercolor
      t.string :explanheaderbackgcolor
      t.string :errorfieldcolor
      t.string :errorcolor
      t.string :warningcolor
      t.string :notificationcolor
      t.string :successcolor

      t.timestamps
    end
  end
end
