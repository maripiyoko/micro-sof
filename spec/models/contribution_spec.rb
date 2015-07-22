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
end
