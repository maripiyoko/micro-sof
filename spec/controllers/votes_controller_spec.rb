require 'rails_helper'

RSpec.describe VotesController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:question) { FactoryGirl.create(:question, user: user) }
  let(:answer) { FactoryGirl.create(:answer, user: user) }

  it "初めて質問に投票すると、Voteレコードが追加されること" do
    expect {
      post :vote_up, { id: question.id }
    }.to change(Vote, :count).by(1)
  end
end
