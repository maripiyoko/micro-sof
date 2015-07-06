require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Question. As you add validations to Question, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryGirl.attributes_for(:question)
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # QuestionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  it "有効なファクトリを持つこと" do
    expect(FactoryGirl.create(:question)).to be_valid
  end

  describe "GET #index" do
    questions = 10.times { FactoryGirl.create(:sequence_questions) }

    it "ログインしていないユーザーでも質問一覧が見れること" do
      get :index, {}, valid_session
      expect(assigns(questions)).to eq @questions
    end
  end

  describe "POST #create" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
    end
    context "パラメータが正しい場合" do
      it "新しい質問を作成する" do
        expect {
          post :create, question: valid_attributes
        }.to change(Question, :count).by(1)
      end
    end
  end


end
