class RankingController < ApplicationController

  def index
    unless current_user
      render text: "Session Not Found"
    end
    @ranking_users = User.ranking
  end
end
