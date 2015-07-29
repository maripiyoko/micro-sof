require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:question) { FactoryGirl.create(:question, user: user) }
  let(:answer) { FactoryGirl.create(:answer, user: user) }

  describe "Post#create" do
    before { sign_in user }

    it "質問に投稿すると、コメントが1つ追加されること" do
      comment = FactoryGirl.build(:comment, user: user, commentable: question)
      expect {
        xhr :post, :create, { question_id: question.id, comment: comment.attributes }
      }.to change(Comment, :count).by(1)
    end

    it "回答に投稿すると、コメントが1つ追加されること" do
      comment = FactoryGirl.build(:comment, user: user, commentable: question)
      expect {
        xhr :post, :create, { question_id: question.id, answer_id: answer.id, comment: comment.attributes }
      }.to change(Comment, :count).by(1)
    end
  end

end
