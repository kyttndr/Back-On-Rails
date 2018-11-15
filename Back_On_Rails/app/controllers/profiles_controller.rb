class ProfilesController < ApplicationController
  before_action :set_user, only: [:new, :create, :edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]

  def new
    @profile = @user.create_profile
  end

  def create
    @profile = @user.profile.create(profile_params)
  end

  def show
    @profile = @user.profile
  end

  def edit
    @profile = @user.profile
  end

  def update
    if @user.profile.update(profile_params)
      redirect_to @user
    else
      render edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :phone_number, :date_of_birth)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def require_same_user
    if current_user != @user
      flash[:danger] = "you can only edit or delete your own profile"
      redirect_to users_path
    end
  end

end
