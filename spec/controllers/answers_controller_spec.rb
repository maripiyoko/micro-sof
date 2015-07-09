require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:login_user) { FactoryGirl.create(:user) }
  let(:question) { FactoryGirl.create(:question) }

  describe "POST#create" do
    before { sign_in login_user }

    it "質問に回答が追加出来ること" do
      new_answer = FactoryGirl.build(:answer, question: question)
      expect {
        post :create, { question_id: new_answer.question_id, answer: new_answer.attributes }
      }.to change(Answer, :count).by(1)
    end
  end

  describe "PATCH#update" do
    before { sign_in login_user }

    it "自分の回答ならば、更新できること" do
      my_answer = FactoryGirl.create(:answer, user: login_user)
      updating_body = "変更してみたよ"
      my_answer.body = updating_body
      patch :update, {
        question_id: my_answer.question_id,
        id: my_answer.id,
        answer: my_answer.attributes
      }
      my_answer.reload
      expect(my_answer.body).to eq updating_body
    end

    it "自分の回答でなければ、更新できないこと" do
      other_answer = FactoryGirl.create(:answer)
      updating_body = "更新出来ないはずだよ"
      other_answer.body = updating_body
      patch :update, {
        question_id: other_answer.question_id,
        id: other_answer.id,
        answer: other_answer.attributes
      }
      other_answer.reload
      expect(other_answer.body).not_to eq updating_body
    end
  end

  describe "DELETE#destroy" do
    before { sign_in login_user }

    it "自分の回答ならば、削除出来ること" do
      my_answer = FactoryGirl.create(:answer, user: login_user)
      expect {
        delete :destroy, { question_id: my_answer.question_id, id: my_answer.id }
      }.to change(Answer, :count).by(-1)
    end

    it "自分の回答でないならば、削除できないこと" do
      other_answer = FactoryGirl.create(:answer)
      expect {
        delete :destroy, { question_id: other_answer.question_id, id: other_answer.id }
      }.not_to change(Answer, :count)
    end
  end
end
