class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name, unique: true
      t.string :color
      t.text :description

      t.timestamps null: false
    end
  end
end
