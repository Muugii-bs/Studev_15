class LoginsController < ApplicationController
  protect_from_forgery except: :create

  def create
    unless user = User.find_by(seat: params[:seat])
      raise "Invalid Seat!!"
    end
    session[:user_id] = user.id
    redirect_to root_url
  end

end
