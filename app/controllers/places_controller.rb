class PlacesController < ApplicationController
  def index
  end

  def search
    api_key = "a25d9f2f0098df836513c302dd16daca"
    url = "http://beermapping.com/webservice/loccity/#{api_key}/"

    response = HTTParty.get "#{url}#{params[:city]}"
    @places  = response.parsed_response["bmp_locations"]["location"].map do |place|
      Place.new(place)
    end

    render :index, status: 418
  end
end
