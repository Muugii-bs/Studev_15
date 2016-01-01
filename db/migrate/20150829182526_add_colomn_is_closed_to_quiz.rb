class AddColomnIsClosedToQuiz < ActiveRecord::Migration
  def change
    add_column :quizzes, :is_closed, :boolean, :default => nil
  end
end
