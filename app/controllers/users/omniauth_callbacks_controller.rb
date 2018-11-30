class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    #if @user.persisted?
      #sign_in_and_redirect @user, :event => :authentication
    #else
      #session["devise.facebook_data"] = request.env["omniauth.auth"]
      #session[:user_id] = @user.id
      #redirect_to new_user_registration_url
    #end
    #if @user.persisted?
      #session[:user_id] = @user.id
      #redirect_to root_path
    #else
      #session[:user_id] = @user.id
      #redirect_to new_user_profile_path(@user)
    #end
    if @user.profile.nil?
      #session[:user_id] = @user.id
      #redirect_to new_user_profile_path(@user)
      UserMailer.account_activation(@user).deliver_now
      redirect_to root_path
    else
      session[:user_id] = @user.id
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_path
  end
end
