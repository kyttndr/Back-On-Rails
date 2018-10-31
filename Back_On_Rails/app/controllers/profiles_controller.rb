class ProfilesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @profile = @user.create_profile
  end

  def create
    @user = User.find(params[:user_id])
    @profile = @user.profile.create(profile_params)
  end

  private
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :phone_number, :date_of_birth,
                                    :street_number, :street_name, :city, :province, :country)
  end
end
