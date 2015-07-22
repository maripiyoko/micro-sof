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

require 'rails_helper'

RSpec.describe Question, type: :model do

  it "有効なファクトリをもつこと" do
    expect(FactoryGirl.build(:question)).to be_valid
  end

  it "titleがなければ、無効な状態であること" do
    question = FactoryGirl.build(:question, title: nil)
    question.valid?
    expect(question.errors[:title]).to include("can't be blank")
  end

  it "bodyがなければ、無効な状態であること" do
    question = FactoryGirl.build(:question, body: nil)
    question.valid?
    expect(question.errors[:body]).to include("can't be blank")
  end

  it "titleとbodyがあれば、有効な状態であること" do
    question = FactoryGirl.build(:question, title: 'MY QUESTION', body: 'MY BODY')
    question.valid?
    expect(question).to be_valid
  end

end
