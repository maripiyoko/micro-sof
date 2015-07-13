# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  body             :text(65535)
#  user_id          :integer
#  commentable_id   :integer
#  commentable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.sentence }
    association :user
  end

end
