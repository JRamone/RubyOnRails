require 'rails_helper'

include Helpers

describe "Beer" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username: user[:username], password: "Foobar1")
  end

  it 'can be added if given valid name' do
    visit new_beer_path
    fill_in('beer[name]', with: 'Valid name')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)      

    expect(brewery.beers.count).to eq(1)
  end

  it 'proper error message displayed if given invalid name' do
    visit new_beer_path
    click_button('Create Beer')

    expect(page).to have_content("Name can't be blank")
    expect(brewery.beers.count).to eq(0)
  end

end
