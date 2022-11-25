require 'rails_helper'
require 'database_cleaner/active_record'

RSpec.describe User, type: :model do

  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean
  
  def create_beer_with_rating(object, score)
    beer = FactoryBot.create(:beer)
    FactoryBot.create(:rating, score: score, user: object[:user])
    beer
  end
  
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq ("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryBot.create(:user) }
    let(:test_brewery) { FactoryBot.create(:test_brewery) }
    let(:test_beer) { FactoryBot.create(:test_beer) }
    
    it 'is saved' do
      expect(user).to be_valid
      expect(User.count).to eq(1) 
    end
    
    it 'and with two ratings, has the correct average rating' do
      FactoryBot.create(:rating, score:10, user: user) 
      FactoryBot.create(:rating, score:20, user: user) 

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
      
    end
  end 

  describe "with a faulty password" do
    let(:user){ User.new username: "Pekka"}
    
    it 'is not saved if password is too short' do
      user.password = "Ad1"
      user.password_confirmation = "Ad1"
      user.save

      expect(user).to_not be_valid
      expect(User.count).to eq(0) 
    end

    it 'is not saved if password only contains small letters' do
      user.password = "smallletters"
      user.password_confirmation = "smallletters"
      user.save

      expect(user).to_not be_valid
      expect(User.count).to eq(0) 
    end
    
    it 'is not saved if password does not contain a number' do
      user.password = "ValidPasswordWithoutANumber"
      user.password_confirmation = "ValidPasswordWithoutANumber"
      user.save

      expect(user).to_not be_valid
      expect(User.count).to eq(0) 
    end
  end
  
  describe "Favorite beer" do
    let(:user){ FactoryBot.create(:user) }

    it 'has method for determining one' do
       expect(user).to respond_to(:favorite_beer) 
    end

    it 'without ratings does not have one' do
      expect(user.favorite_beer).to eq(nil) 
    end

    it 'is the only rated if only one rating' do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)  

      expect(user.favorite_beer).to eq(beer)
    end

    it 'is the one with highest rating if several rated' do
      create_beer_with_rating({user: user},10)
      create_beer_with_rating({user: user},30)
      best = create_beer_with_rating({user: user},50)

      expect(user.favorite_beer).to eq(best)
    end

  end

end
