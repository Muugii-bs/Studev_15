class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.datetime :date
      t.string :team1
      t.string :team2

      t.timestamps null: false
    end
  end
end
