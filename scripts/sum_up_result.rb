require 'optparse'

def main(logger)

  quiz_id = nil
  answer_op_id = nil

  OptionParser.new do |opt|
    opt.on('--quiz_id=N', Integer, '集計するクイズID') {|val| quiz_id = val }
    opt.on('--answer_op_id=N', Integer, 'クイズの回答') {|val| answer_op_id = val }
    opt.parse(ARGV)
  end

  unless quiz_id && answer_op_id
    return help
  end

  unless answer_op_id.between?(1, 4)
    raise 'Invalid answer_op_id. answer_op_id must be between 1 and 4'
  end

  quiz = Quiz.find_by(id: quiz_id)
  raise 'Quiz not found!' unless quiz
  raise 'Quiz is not closed yet!' unless quiz.is_closed
  raise 'This quize is already summed up' if quiz.correct.present?

  bets = Bet.where(quiz_id: quiz_id)
  correct_bets = bets.select {|bet| bet.answer == answer_op_id}
  user_map = User.where(id: correct_bets.map(&:user_id)).each_with_object({}) do |user, memo|
    memo[user.id] = user
  end
  magnification = quiz.odd.read_attribute("op#{answer_op_id}")

  logger.info('Start Transaction!')

  Quiz.transaction do
    correct_bets.each do |correct_bet|
      user = user_map[correct_bet.user_id]
      user.update(
        point: user.point + (correct_bet.amount * magnification).ceil
      )
    end
    quiz.update(
      correct: answer_op_id
    )
  end

  logger.info('Finished!')
end

def help
  puts <<HELP
  Synopsis:
    bundle exec rails runner #{__FILE__} --quiz_id=1 --answer_op_id=3
HELP
end

main(Logger.new(STDOUT))
