FactoryBot.define do

  factory :user do
    username { "Pekka" }
    password { "Foobar1" }
    password_confirmation { "Foobar1" }
  end

  factory :brewery do
    name { "anynymous" }
    year { 1990 }
  end

  factory :beer do
    name { "anonymous" }
    style { "Lager" }
    brewery
  end

  factory :rating do
    score { 10 }
    beer
    user
  end

end
