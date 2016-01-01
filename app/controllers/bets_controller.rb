class BetsController < ApplicationController
  def create
    attributes = bet_params
    if Quiz.find(attributes[:quiz_id]).is_closed
      render text: "This Quiz is Closed", status: 403
      return
    end
    if attributes[:amount].to_i > current_user.point
      render text: "Over Bet Amount!!", status: 409
      return
    end
    @bet = Bet.new(bet_params)
    @bet.save!
    user_update
    odds_update
    render json: @bet.quiz.odd.to_json
  end

  def update
    user_update
    odds_update
  end

# private
  def user_update
    @user = current_user
    @user.point -= @bet.amount
    @user.save!
  end

  def odds_update
    quiz_id = params[:quiz_id]
    @bets = Bet.where(quiz_id: quiz_id)
    @quiz = Quiz.find(quiz_id)
    op = [0,0,0,0]  # temp
    @bets.each do |bet|
      case bet.answer
        when 1 then
          op[0] += bet.amount
        when 2 then
          op[1] += bet.amount
        when 3 then
          op[2] += bet.amount
        when 4 then
          op[3] += bet.amount
      end
    end
    sum = op.inject(:+)
    @odd = @quiz.odd
    @odd.op1 = (sum.to_f/op[0]).to_d.ceil(1).to_f if op[0] != 0
    @odd.op2 = (sum.to_f/op[1]).to_d.ceil(1).to_f if op[1] != 0
    @odd.op3 = (sum.to_f/op[2]).to_d.ceil(1).to_f if op[2] != 0
    @odd.op4 = (sum.to_f/op[3]).to_d.ceil(1).to_f if op[3] != 0
    @odd.save!
  end

  private
    def bet_params
      {
        user_id: current_user.id,
        quiz_id: params[:quiz_id],
        answer: params[:answer],
        amount: params[:amount]
      }
    end
end
