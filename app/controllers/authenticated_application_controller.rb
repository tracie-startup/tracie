class AuthenticatedApplicationController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :authenticate_user!

  private

  def authenticate_user_from_token!
    ## Read from HTTP Header
    # user_email = request.headers["HTTP_USER_EMAIL"]
    # user_token = request.headers["HTTP_AUTH_TOKEN"]

    # Read from Paramerters
    user_email = params["email"]
    user_token = params["token"]

    user = user_email && User.find_by_email(user_email)

    if user && Devise.secure_compare(user.authentication_token, user_token)
      sign_in user, store: false
    end
  end

end
