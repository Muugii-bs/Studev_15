# == Schema Information
#
# Table name: quizzes
#
#  id         :integer          not null, primary key
#  content    :text
#  op1        :string
#  op2        :string
#  op3        :string
#  op4        :string
#  correct    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  odd_id     :integer
#  title      :string
#  hint       :text
#  closed_at  :datetime
#  is_closed  :boolean
#

class Quiz < ActiveRecord::Base
  has_many :bet
  has_many :game_quiz
  belongs_to :odd
end
