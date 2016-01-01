# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  seat            :string
#  point           :integer
#  password_digest :string
#  game_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  has_secure_password

  has_many :bet
  belongs_to :game

  scope :ranking, -> {order(point: :desc).limit(5)}


end
