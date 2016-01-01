class AddColumnToQuiz < ActiveRecord::Migration
  def change
    add_column :quizzes, :odd_id, :integer
  end
end
