class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_params)
    if @user.save
      flash[:notice] = "Thank you for signing up!"
      redirect_to root_url
    else
      flash[:alert] = "Invalid Form!"
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  # PRIVATE FUNCTIONS
  private

  def allowed_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
