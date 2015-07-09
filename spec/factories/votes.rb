# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  votable_id   :integer
#  votable_type :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  score        :integer          default(0)
#

FactoryGirl.define do
  factory :vote do
    user nil
  end

end
