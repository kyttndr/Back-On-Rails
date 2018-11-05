class ProfilesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @profile = @user.create_profile
  end

  def create
    @user = User.find(params[:user_id])
    @profile = @user.profile.create(profile_params)
  end

  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def update
    @user = User.find(params[:user_id])
    if @user.profile.update(profile_params)
      redirect_to @user
    else
      render edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :phone_number, :date_of_birth,
                                    :street_number, :street_name, :city, :province, :country)
  end
end
