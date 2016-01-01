class CreateGameQuizzes < ActiveRecord::Migration
  def change
    create_table :game_quizzes do |t|
      t.integer :game_id
      t.integer :quiz_id

      t.timestamps null: false
    end
  end
end
