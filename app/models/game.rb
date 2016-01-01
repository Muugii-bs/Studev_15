# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  date       :datetime
#  team1      :string
#  team2      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Game < ActiveRecord::Base
  has_many :game_quiz
  has_many :user
end
