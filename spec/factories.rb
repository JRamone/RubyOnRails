FactoryBot.define do
  sequence :username do |n|
    "Pekka#{n}"
  end

  factory :user do
    username { generate :username }
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
