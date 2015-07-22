# == Schema Information
#
# Table name: badges
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  color       :string(255)
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do

  factory :badge do
    name { FactoryGirl.generate(:badge_names) }
    color :silver
    description "Test badge."
  end

  sequence :badge_names do |n|
    "Badge #{n}"
  end
end
