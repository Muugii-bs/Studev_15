# == Schema Information
#
# Table name: bets
#
#  id         :integer          not null, primary key
#  answer     :integer
#  amount     :integer
#  user_id    :integer
#  quiz_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Bet < ActiveRecord::Base
  belongs_to :user
  belongs_to :quiz
end
