# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  comment     :text(65535)
#  user_id     :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :answer do
    comment { Faker::Lorem.sentence }
    association :user
    association :question
  end

end
