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

  describe "GET #edit" do
    let(:question) { FactoryGirl.create(:question) }

    context "ログインしていない場合" do
      it "編集画面が見れないこと" do
        get :edit, {id: question.id}
        expect(assigns(:question)).not_to eq question
      end

      it "編集画面ではなくサインイン画面にリダイレクトされること" do
        get :edit, {id: question.id}
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context "ログインしている場合" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
      end

      context "自分の質問ならば" do
        let(:my_question) { FactoryGirl.create(:question, user: user) }
        it "編集出来るように表示されていること" do
          get :edit, {id: my_question.id}
          expect(assigns(:question)).to eq my_question
        end

        it "編集画面が表示されていること" do
          get :edit, {id: my_question.id}
          expect(response).to render_template("edit")
        end
      end

      context "他の人の質問ならば" do
        let(:other_question) { FactoryGirl.create(:question) }
        it "質問一覧へリダイレクトされること" do
          get :edit, {id: other_question.id}
          expect(response).to redirect_to('/questions')
        end
      end
    end
  end

  describe "GET #show" do
    let(:question) { FactoryGirl.create(:question) }

    context "ログインしていない場合" do
      it "詳細画面が見れること" do
        get :show, {id: question.id}
        expect(assigns(:question)).to eq question
      end
    end
  end

  describe "PATCH #update" do
    context "ログインしていない場合" do
      let(:question) { FactoryGirl.create(:question) }
      it "サインイン画面にリダイレクトされること" do
        put :update, {id: question.id, question: question.attributes }
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context "ログインしている場合" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
      end
      let(:my_question) { FactoryGirl.create(:question, user: user) }

      it "自分の質問ならば、更新出来ること" do
        my_question.title = "EDITED TITLE"
        put :update, { id: my_question.id, question: my_question.attributes }
        expect(assigns(:question)).to eq my_question
        my_question.reload
        expect(my_question.title).to eq "EDITED TITLE"
      end

      it "他の人の質問ならば、質問一覧にリダイレクトされること" do
        other_question = FactoryGirl.create(:question)
        put :update, { id: other_question.id, question: other_question.attributes }
        expect(response).to redirect_to('/questions')
      end
    end
  end
end
