class SessionsController < ApplicationController
  def create
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}!"
    rescue
      flash[:warning] = "There was an error while trying to authenticate you..."
    end
    redirect_to request.env['omniauth.origin'] || root_path
    #^ redirects to previous page
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = 'Logged out successfully!'
    end
    redirect_to(:back)
    #^ redirects to previous page
  end
end
