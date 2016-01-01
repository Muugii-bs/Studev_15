# == Schema Information
#
# Table name: odds
#
#  id         :integer          not null, primary key
#  op1        :float
#  op2        :float
#  op3        :float
#  op4        :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Odd < ActiveRecord::Base
  has_one :quiz
end
