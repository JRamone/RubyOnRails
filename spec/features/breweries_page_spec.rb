require 'rails_helper'

describe "Breweries page" do
  it "should not have any before been created" do
    visit breweries_path
    expect(page).to have_content 'Breweries'
    expect(page).to have_content 'Number of active breweries: 0'
    expect(page).to have_content 'Number of retired breweries: 0'
  end

end

describe "when breweries exists" do
  
  before :each do
    #käytä @-merkkiä, jotta muuttuja näkyy it-lohkoissa
    @breweries = ["Koff", "Karjala", "Schlenkerla"]
    year = 1896
    @breweries.each do |brewery_name|
      FactoryBot.create(:brewery, name: brewery_name, year: year+=1)
    end
    @breweries = Brewery.all
    visit breweries_path

  end

  it "lists the existing active breweries and their total number" do
    expect(page).to have_content "Number of active breweries: #{@breweries.select{|b| b.active}.count}"

    @breweries.each do |brewery_name|
      expect(page).to have_content brewery_name
    end
    
  end

  it "allows user to navigate to page of a Brewery" do
    click_link "Koff"

    expect(page).to have_content "Koff"
    expect(page).to have_content "Established in 1897"
  end

    
end
