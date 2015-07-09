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

require 'rails_helper'

RSpec.describe Vote, type: :model do

  let(:user) { FactoryGirl.create(:user) }
  let(:question) { FactoryGirl.create(:question, user: user) }
  let(:answer) { FactoryGirl.create(:answer, user: user) }

  it "User IDとQuestion IDがあれば、有効な状態であること" do
    vote = Vote.new
    vote.user = user
    vote.votable = question
    expect(vote).to be_valid
  end

  it "User IDとAnswer IDがあれば、有効な状態であること" do
    vote = Vote.new
    vote.user = user
    vote.votable = answer
    expect(vote).to be_valid
  end

  it "User IDがないと、無効な状態であること" do
    vote = Vote.new
    vote.votable = answer
    expect(vote).not_to be_valid
  end

  it "scoreが-1,0,1のどれかなら、有効な状態であること" do
    vote = Vote.new
    vote.user = user
    vote.votable = question
    vote.score = -1
    expect(vote).to be_valid
    vote.score = 0
    expect(vote).to be_valid
    vote.score = 1
    expect(vote).to be_valid
  end

  it "scoreが-1,0,1の範囲外なら、無効な状態であること" do
    vote = Vote.new
    vote.user = user
    vote.votable = question
    vote.score = -2
    expect(vote).not_to be_valid
    vote.score = 2
    expect(vote).not_to be_valid
    vote.score = 100
    expect(vote).not_to be_valid
  end

  it "１つの質問（回答）に対して、１人１回しか投稿できないこと" do
    vote = Vote.new
    vote.user = user
    vote.votable = question
    vote.save
    vote2 = Vote.new
    vote2.user = user
    vote2.votable = question
    expect(vote2).not_to be_valid
  end

end
