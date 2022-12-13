class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username]

    if user&.authenticate(params[:password])
      if !user.enabled
        redirect_to signin_path, notice: "You had one too many last time.. Contact Admins and ask for mercy."
        return
      end

      session[:user_id] = user.id if user
      redirect_to user, notice: "May the Beer be with you, #{params[:username]}."
    else
      redirect_to signin_path, notice: "Username and/or password mismatch"

    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
