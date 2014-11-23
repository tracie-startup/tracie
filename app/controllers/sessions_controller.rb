class SessionsController < ApplicationController
  def new
    user = User.find_by_auth_token(params[:auth_token]) 
    if user
      session[:user_id] = user.id
      redirect_to agile_pois_url, notice: "Login erfolgreich"  
    else
      redirect_to root_url, error: "Ungültiges Token"
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_url, notice: "Session gelöscht"
  end
end
