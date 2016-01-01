# == Schema Information
#
# Table name: game_quizzes
#
#  id         :integer          not null, primary key
#  game_id    :integer
#  quiz_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GameQuiz < ActiveRecord::Base
  belongs_to :game
  belongs_to :quiz
end
