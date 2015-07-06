FactoryGirl.define do

  factory :question do
    title "Test Question"
    body { Faker::Lorem.sentence }
    association :user
  end

  factory :sequence_questions, class: Question do
    title { FactoryGirl.generate(:question_titles) }
    body { Faker::Lorem.paragraphs }
    association :user
  end

  sequence :question_titles do |n|
    "Question #{n}"
  end

end
