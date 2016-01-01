class AddColumnClosedAtToQuiz < ActiveRecord::Migration
  def change
    add_column :quizzes, :closed_at, :datetime
  end
end
