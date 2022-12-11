require 'rails_helper'

include Helpers

describe "User" do
  
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username: user[:username], password: "Foobar1")
  end 

  describe "who has signed up" do

    it "can signin with right credentials" do
      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content user[:username]
    end
    
    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka1", password: "Foobar2")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
    
    it "when signed with good credentials, user is added to the system" do
      visit signup_path
      fill_in('user_username', with: 'Pekka23')
      fill_in('user_password', with: 'Foobar1')
      fill_in('user_password_confirmation', with: 'Foobar1')
      
      expect{
        click_button('Create User')
      }.to change{User.count}.by(1)
    end
    
  end

  describe "who has signed in" do

    describe "homepage display" do

      it 'ratings made by user are displayed correctly' do
        create_beer_with_rating({user: user}, 15)
        create_beer_with_rating({user: user}, 50)
        create_beer_with_rating({user: user}, 25)
        visit user_path(user, user.id)
        @ratings = user.ratings
        @ratings.each do |rating|
          expect(page).to have_content("#{rating.beer.name}")
        end
      end

      it 'ratings made by another user are not displayed' do
        foreign_user = FactoryBot.create :user
        create_beer_with_rating({user: foreign_user}, 15)
        create_beer_with_rating({user: foreign_user}, 25)
        visit user_path(user, user.id)

        @ratings = foreign_user.ratings
        @ratings.each do |rating|
          expect(page).to_not have_content("#{rating.beer.name}")
        end
        expect(Rating.count).to eq(2)
      end 

      it 'Favorite style is displayed correctly' do
        create_beer_with_rating({user: user}, 45)
        create_beer_with_rating({user: user}, 25)
        visit user_path(user, user.id)

        expect(page).to have_content("Test_style")
      end 

      it 'Favorite brewery is displayed correctly' do
        create_beer_with_rating({user: user}, 45, brewery_name="MyFavoriteBrewery")
        create_beer_with_rating({user: user}, 25)
        visit user_path(user, user.id)

        expect(page).to have_content("MyFavoriteBrewery")
      end 

    end 
  describe "Rating" do
    it 'can be deleted' do
        create_beer_with_rating({user: user})
        create_beer_with_rating({user: user})
        visit user_path(user)
        expect(page).to have_content("Has made #{Rating.count} ratings,")

        all(:link, href:"/ratings/#{user.ratings.last.id}").first.click

    end

  end

  end

end
