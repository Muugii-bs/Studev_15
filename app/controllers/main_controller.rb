class MainController < ApplicationController

  def index
    unless @user = current_user
      render text: "Session Not Found"
    end
    @quizzes = Quiz.all
    @odds = Odd.all
  end

  def ajax_render
    @user = current_user
    @quizzes = Quiz.all

    render "ajax_render", :formats => [:json], :handlers => [:jbuilder]
  end

end
