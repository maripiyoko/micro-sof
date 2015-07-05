FactoryGirl.define do

  factory :question do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraphs }
    association :user
  end

end
