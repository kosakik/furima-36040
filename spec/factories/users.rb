FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.name}
    email                 {Faker::Internet.free_email}
    password              {Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)}
    password_confirmation {password}
    last_name             { Gimei.name.last.kanji}
    first_name            { Gimei.name.first.kanji}
    last_name_kana        { Gimei.name.last.katakana}
    first_name_kana       { Gimei.name.first.katakana}
    birth_date            { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end