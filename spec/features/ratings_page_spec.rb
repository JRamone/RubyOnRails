require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" } 
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery: brewery } 
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery: brewery } 
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username: user[:username], password: "Foobar1")
  end

  it 'when given, is registered to the beer and user who is signed in' do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it 'most active users are displayed correctly' do
    create_beer_with_rating({user: user}, 15)
    create_beer_with_rating({user: user}, 30)
    create_beer_with_rating({user: user}, 25)
    visit ratings_path
    @most_active_users = User.most_active 3
    @most_active_users.each do |user|
      expect(page).to have_content("#{user.username} #{user.ratings.count} ratings")
    end
    expect(Rating.count).to eq(3)
  end

  it 'recent ratings are displayed correctly' do
    create_beer_with_rating({user: user}, 15)
    create_beer_with_rating({user: user}, 30)
    create_beer_with_rating({user: user}, 25)
    visit ratings_path

    @ratings = Rating.recent
    @ratings.each do |rating|
      expect(page).to have_content("#{rating.beer.name}, #{rating.score}, rated by #{rating.user.username}")
    end
    expect(Rating.count).to eq(3)
  end

end
