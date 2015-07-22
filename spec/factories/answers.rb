# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  body        :text(65535)
#  user_id     :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  sum_votes   :integer          default(0)
#

FactoryGirl.define do
  factory :answer do
    body { Faker::Lorem.sentence }
    association :user
    association :question
  end

  factory :sequence_answers, class: Answer do
    body { Faker::Lorem.paragraphs }
    association :user
    association :question
  end

end
