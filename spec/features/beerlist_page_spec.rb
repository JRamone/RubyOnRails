require 'rails_helper'

describe "Beerlist page" do
  before :all do
    Capybara.register_driver :chrome do |app|
      options = Selenium::WebDriver::Chrome::Options.new(args: %w[headless])
      Capybara::Selenium::Driver.new app, browser: :chrome,
        options: options
    end

    Capybara.javascript_driver = :chrome
    #WebMock.disable_net_connect!(allow_localhost: true)
    WebMock.allow_net_connect!

  end
  before :each do
    @brewery1 = FactoryBot.create(:brewery, name: "Koff")
    @brewery2 = FactoryBot.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryBot.create(:beer, name: "Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryBot.create(:beer, name: "Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryBot.create(:beer, name: "Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  it "shows one known beer", :js => true do
    visit beerlist_path
    expect(page).to have_content "Nikolai"
  end

  it "sorted by name by default", :js => true do
    visit beerlist_path
    find('#beerlist').find('tr:nth-child(1)').assert_text('Fastenbier')
    find('#beerlist').find('tr:nth-child(2)').assert_text('Lechte Weisse')
    find('#beerlist').find('tr:nth-child(3)').assert_text('Nikolai')
  end
  
  it "ordering by style works correctly", :js => true do
    visit beerlist_path
    find('#style').click
    find('#beerlist').find('tr:nth-child(1)').assert_text('Lager')
    find('#beerlist').find('tr:nth-child(2)').assert_text('Rauchbier')
    find('#beerlist').find('tr:nth-child(3)').assert_text('Weizen')
  end

  it "ordering by brewery works correctly", :js => true do
    visit beerlist_path
    find('#brewery').click
    find('#beerlist').find('tr:nth-child(1)').assert_text('Ayinger')
    find('#beerlist').find('tr:nth-child(2)').assert_text('Koff')
    find('#beerlist').find('tr:nth-child(3)').assert_text('Schlenkerla')
  end

end
