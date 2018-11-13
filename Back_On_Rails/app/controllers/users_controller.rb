class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_params)
    if @user.save
      flash[:notice] = "Thank you for signing up!"
      redirect_to new_user_profile_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(allowed_params)
      flash[:notice] = "Successfully edited"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Deleted"
    redirect_to users_path
  end
  
  def my_friends
    @friendships = current_user.friends
  end
  
  def search
  
  end

  # PRIVATE FUNCTIONS
  private

  def allowed_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
