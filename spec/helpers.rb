module Helpers

  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end
  
  def create_beer_with_rating(object, score=15, style="Lager", brewery_name="Koff")
    brewery = FactoryBot.create(:brewery, name: brewery_name)
    beer = FactoryBot.create(:beer,style: style, brewery: brewery)
    FactoryBot.create(:rating, beer: beer, score: score, user: object[:user])
    beer
  end
  
  def create_beers_with_many_ratings(object, scores)
    scores.each do |score|
      create_beer_with_rating(object,score)
    end
  end
end
