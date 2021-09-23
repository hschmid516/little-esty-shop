FactoryBot.define do
  factory :item, class: Item do
    name { Faker::Lorem.unique.sentence(word_count: 3)}
    description { Faker::Lorem.unique.sentence(word_count: 7) }
    unit_price { 5 }
    created_at { "2012-03-27 14:53:59 UTC" }
    updated_at { "2012-03-27 14:53:59 UTC" }
  end
end
