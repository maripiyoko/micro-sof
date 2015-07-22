# == Schema Information
#
# Table name: contributions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  badge_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Contribution, type: :model do

  it "有効なファクトリを持つこと" do
    expect(FactoryGirl.create(:contribution)).to be_valid
  end

  it "１人のユーザーに同じバッジを複数付与できないこと" do
    badge = FactoryGirl.create(:badge)
    user = FactoryGirl.create(:user)
    user.badges << badge
    user.save
    expect(user).to be_valid
    user.reload
    user.badges << badge
    expect(user.badges.count).to eq(1)
  end

  it "１つのバッジに同じユーザーが複数割り当てられないこと" do
    badge = FactoryGirl.create(:badge)
    user = FactoryGirl.create(:user)
    badge.users << user
    badge.save
    expect(badge).to be_valid
    badge.reload
    badge.users << user
    expect(badge.users.count).to eq(1)
  end

end
