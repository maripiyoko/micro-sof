require 'rails_helper'

RSpec.describe VotesController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:question) { FactoryGirl.create(:question, user: user) }
  let(:answer) { FactoryGirl.create(:answer, user: user) }

  describe "POST#up" do
    before { sign_in user }

    it "初めて質問に投票すると、Voteレコードが追加されること" do
      expect {
        xhr :post, :up, { id: question.id }
      }.to change(Vote, :count).by(1)
    end

    it "２回目以降の投票では、Voteレコードが追加されないこと" do
      vote = Vote.new( user: user, votable: question )
      vote.save
      expect {
        xhr :post, :up, { id: question.id }
      }.not_to change(Vote, :count)
      vote.reload
      pp vote
    end
  end

  describe "DELETE#down" do
    before { sign_in user }

    it "初めて投票-1すると、Voteレコードが追加されること" do
      expect {
        xhr :delete, :down, { id: question.id }
      }.to change(Vote, :count).by(1)
    end

  end
end
