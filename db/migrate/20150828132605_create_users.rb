class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :seat
      t.integer :point
      t.string :password_digest
      t.integer :game_id

      t.timestamps null: false
    end
  end
end
