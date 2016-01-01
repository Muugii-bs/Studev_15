class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.text :content
      t.string :op1
      t.string :op2
      t.string :op3
      t.string :op4
      t.integer :correct

      t.timestamps null: false
    end
  end
end
