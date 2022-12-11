require 'rails_helper'

RSpec.describe Beer, type: :model do

  let(:brewery){ Brewery.create name: "test_brewery", year: 2002}
  let(:style){ Style.create name: "test style", description: "Testcription" }
  let(:beer){ Beer.new name:"test_beer", style: style, brewery: brewery}

  describe "with a proper name, style and brewery" do

    it 'is saved' do
      beer.save 

      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end 

  end

  describe "With a faulty attribute" do

    describe "Name" do

      it 'is not saved if empty' do
        beer.name = nil
        beer.save
          
        expect(beer).to_not be_valid
        expect(Beer.count).to eq(0)
      end 

    end
    describe "Style" do

      it 'is not saved if empty' do
        beer.style = nil
        beer.save
          
        expect(beer).to_not be_valid
        expect(Beer.count).to eq(0)
      end 

    end

  end

end
