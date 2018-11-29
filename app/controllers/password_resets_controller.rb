class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expired, only: [:edit, :update] #this checks if reset link expired
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      UserMailer.password_reset(@user).deliver_now
      flash[:info] = "Email with password reset instructions sent to #{@user.email.downcase} !"
      redirect_to root_path
    else
      flash[:danger] = "Email address not found"
      @user = User.new
      @user.errors.add(:email, " address not found")
      render 'new'
    end
  end

  def edit

  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "Can not be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)
      puts("params are fine")
      session[:user_id] = @user.id
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "Password has been reset."
      redirect_to root_path
    else
      puts("something went wrong")
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
    puts("Found user with email #{@user.email}")
  end

  # Confirm that password is being reset for valid activated user
  def valid_user
    unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
      redirect_to root_path
    end
  end

  def check_expired
    if @user.password_reset_expired?
      flash[:danger] = "Password reset link expired"
      redirect_to new_password_reset_url
    end
  end
end
