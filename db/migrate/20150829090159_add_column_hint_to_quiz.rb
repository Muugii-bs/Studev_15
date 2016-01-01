class AddColumnHintToQuiz < ActiveRecord::Migration
  def change
    add_column :quizzes, :hint, :text
  end
end
