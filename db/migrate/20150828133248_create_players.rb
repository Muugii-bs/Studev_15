class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.text :story
      t.float :data

      t.timestamps null: false
    end
  end
end
