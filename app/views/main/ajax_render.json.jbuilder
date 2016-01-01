json.user do |json|
  json.id @user.id
  json.seat @user.seat
  json.point @user.point
  json.game do
    json.date @user.game.date
    json.team1 @user.game.team1
    json.team2 @user.game.team2
  end

  json.bets do |json|
    json.array!(@user.bet) do |bet|
      json.extract! bet, :id, :answer, :amount, :user_id, :quiz_id
    end
  end
end

json.quizzes do |json|
  json.array!(@quizzes) do |quiz|
    json.extract! quiz, :id, :title, :content, :op1, :op2, :op3, :op4, :hint, :closed_at, :correct, :is_closed
    json.odds do
      json.op1 quiz.odd.op1
      json.op2 quiz.odd.op2
      json.op3 quiz.odd.op3
      json.op4 quiz.odd.op4
    end
  end
end
