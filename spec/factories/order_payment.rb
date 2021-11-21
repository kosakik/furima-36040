FactoryBot.define do
  factory :order_payment do
    postal_code   {'123-4567'}
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city          { Faker::Address.city }
    addresses     { Faker::Address.street_address }
    building      { Faker::Address.street_address }
    phone_number  { Faker::Number.number(digits: 11) }
    token         {"tok_abcdefghijk00000000000000000"}
  end
end