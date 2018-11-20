class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

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
      session[:user_id] = @user.id
      redirect_to new_user_profile_path(@user)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(allowed_params)
      flash[:notice] = "Successfully edited"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    session[:user_id] = nil
    @user.destroy
    flash[:notice] = "Deleted"
    redirect_to users_path
  end
  
  def my_friends
    @friendships = current_user.friends
  end
  
  def search
    if params[:search_param].blank?
      flash[:notice] = "You have entered an empty search string"
    else
      @users = User.search(params[:search_param])
      @users = current_user.except_current_user(@users)
      flash[:notice] = "No users match this search criteria" if @users.blank?
    end
    render 'my_friends'
  end

  def add_friend
    @friend = User.find(params[:friend])
    #current_user.friendships.build(friend_id: @friend.id)

    #if current_user.save
    if current_user.friends << @friend
      flash[:notice] = "Friend was successfully added"
    else
      flash[:danger] = "Friend was failed to be added"
    end
    redirect_to my_friends_path
  end

  # PRIVATE FUNCTIONS
  private

  def allowed_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:danger] = "you can only edit or delete your own user"
      redirect_to users_path
    end
  end

end
