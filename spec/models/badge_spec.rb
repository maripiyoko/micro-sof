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

require 'rails_helper'

RSpec.describe Badge, type: :model do

  it "有効なファクトリをもつこと" do
    expect(FactoryGirl.create(:badge)).to be_valid
  end

  it "nameがなければ、無効な状態であること" do
    badge = FactoryGirl.build(:badge, name: nil)
    badge.valid?
    expect(badge.errors[:name]).to include("can't be blank")
  end

  it "nameが重複していれば、無効な状態であること" do
    name = "BADGE1"
    FactoryGirl.create(:badge, name: name)
    badge = FactoryGirl.build(:badge, name: name)
    badge.valid?
    expect(badge.errors[:name]).to include("has already been taken")
  end

  it "定義されたcolorでなければ、無効な状態であること" do
    badge = FactoryGirl.build(:badge, color: "invalid color")
    badge.valid?
    expect(badge.errors[:color]).to include("is not included in the list")
  end

  it "colorがなければ、無効な状態であること" do
    badge = FactoryGirl.build(:badge, color: nil)
    badge.valid?
    expect(badge.errors[:color]).to include("can't be blank")
  end


  it "nameとcolorがあれば、有効な状態であること" do
    badge = FactoryGirl.create(:badge, name: "First Badge", color: :bronze)
    expect(badge).to be_valid
  end
end
