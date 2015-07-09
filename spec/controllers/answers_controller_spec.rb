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

end
