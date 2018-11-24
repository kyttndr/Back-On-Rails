class PlacesController < ApplicationController
  before_action :require_user, except: [:index, :show]

  def index
    @places = Place.all.select {|p| p.items.count > 0}
    gon.places = @places
  end

  def new
    @place = Place.new
    @place.user = current_user
  end

  def create
    @place = Place.new(place_params)
    @place.user = current_user
    if @place.save
      flash[:success] = "Place added!"
      redirect_to my_places_path
    else
      render 'new'
    end
  end

  def show
    @place = Place.find(params[:id])
    gon.place = @place
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy
    flash[:notice] = "Deleted"
    redirect_to my_places_path
  end

  private

  def place_params
    params.require(:place).permit(:address, :latitude, :longitude)
  end

  def require_user
    if !logged_in?
      flash[:danger] = "you need to log in"
      redirect_to places_path
    end
  end

end
