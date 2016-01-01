require 'optparse'

def main(logger)
  quiz_id = nil
  OptionParser.new do |opt|
    opt.on('--quiz_id=N', Integer, 'クローズするクイズID') {|val| quiz_id = val }
    opt.parse(ARGV)
  end

  unless quiz_id
    return help
  end

  quiz = Quiz.find_by(id: quiz_id)
  raise 'Quiz not found!' unless quiz
  raise 'This quize is already closed' if quiz.is_closed

  quiz.update(is_closed: true)

  logger.info('Finished!')
end

def help
  puts <<HELP
  Synopsis:
    bundle exec rails runner #{__FILE__} --quiz_id=1
HELP
end

main(Logger.new(STDOUT))
