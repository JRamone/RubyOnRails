require 'rails_helper'

describe "Places" do
  let!(:weather){ Weather.new city: "Weathertown", temperature: 2, wind_dir: "NE", wind_speed: 20, weather_icons: [""]}
  
  it 'if one is returned by the API, it is shown at the page' do
    allow(BeermappingApi).to receive(:places_in).with('kumpula').and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )
    allow(WeatherApi).to receive(:weather_in).with('kumpula').and_return(weather)

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it 'if many is returned by the API, all of them are shown at the page' do
    allow(WeatherApi).to receive(:weather_in).with('kumpula').and_return(weather)
    allow(BeermappingApi).to receive(:places_in).with('kumpula').and_return(
    places = [  Place.new( name: "Oljenkorsi1", id: 1 ), 
                Place.new( name: "Oljenkorsi2", id: 2 ),
                Place.new( name: "Oljenkorsi3", id: 3 ),]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    places.each do |place| 
      expect(page).to have_content place.name 
    end
  end
  it 'if none is returned by the API, notification is shown at the page' do
    allow(BeermappingApi).to receive(:places_in).with('kumpula').and_return([])
    allow(WeatherApi).to receive(:weather_in).with('kumpula').and_return(weather)

    visit places_path
    searched_city = fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content "No locations in #{searched_city.text}"
  end
end
