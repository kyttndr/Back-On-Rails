class AccountActivationsController < ApplicationController\

  def edit
    @user = User.find_by(email: params[:email])
    if @user && !@user.activated && @user.authenticated?(:activation, params[:id])
      @user.update_attribute(:activated, true)
      @user.update_attribute(:activated_at, Time.zone.now)
      session[:user_id] = @user.id
      flash[:success] = "Account Activated!"
      redirect_to new_user_profile_path(@user)
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_path
    end
  end
end
