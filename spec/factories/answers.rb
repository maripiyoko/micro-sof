FactoryGirl.define do
  factory :answer do
    comment { Faker::Lorem.sentence }
    association :user
    association :question
  end

end
