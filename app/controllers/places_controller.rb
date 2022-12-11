class PlacesController < ApplicationController
  def index
  end

  def search
    @weather = WeatherApi.weather_in(params[:city])
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index, status: 418
    end
  end

  def show
  end
end
