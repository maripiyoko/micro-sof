# == Schema Information
#
# Table name: questions
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  body               :text(65535)
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  sum_votes          :integer          default(0)
#  approved_answer_id :integer
#

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
