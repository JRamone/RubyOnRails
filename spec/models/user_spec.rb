require 'rails_helper'

RSpec.describe User, type: :model do
  
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
    let(:user){ User.create username: "Pekka", password: "Secret1", password_confirmation: "Secret1" }
    let(:test_brewery) { Brewery.new name: "test", year: 2000}
    let(:test_beer) { Beer.create name: "testbeer", style: "teststyle", brewery: test_brewery }
    
    it 'is saved' do
      expect(user).to be_valid
      expect(User.count).to eq(1) 
    end
    
    it 'and with two ratings, has the correect average rating' do
      rating = Rating.create score: 10, beer: test_beer
      rating2 = Rating.create score: 20, beer: test_beer

      user.ratings << rating
      user.ratings << rating2

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
end
