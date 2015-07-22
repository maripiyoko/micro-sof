require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

RSpec.feature "Contributes", type: :feature do
  # ユーザーにバッジを付与する
  scenario "初めての質問をしたユーザーは、生徒バッジを付与される" do
    user = FactoryGirl.create(:user)
    login_as(user, scope: :user)

    visit questions_path
    click_link 'New Question'
    expect {
      fill_in 'Title', with: 'My First Question'
      fill_in 'Body', with: '最初の質問をつくってみる'
      click_button 'Create Question'
    }.to change(Contribution, :count).by(1)
  end

  scenario "初めて回答したユーザーは、先生バッジを付与される" do
    user = FactoryGirl.create(:user)
    login_as(user, scope: :user)
    question = FactoryGirl.create(:question)

    visit question_path(question)
    expect {
      fill_in 'Body', with: '最初の回答'
      click_button 'Create Answer'
    }.to change(Contribution, :count).by(1)
  end

  scenario "質問＋回答合わせて10個したユーザーは、常連バッジを付与される" do
    user = FactoryGirl.create(:user)
    login_as(user, scope: :user)
    5.times { FactoryGirl.create(:sequence_questions, user: user) }
    4.times { FactoryGirl.create(:sequence_answers, user: user) }

    visit questions_path
    click_link 'New Question'
    expect {
      fill_in 'Title', with: 'My 10th Question'
      fill_in 'Body', with: 'いつもの質問をつくってみる'
      click_button 'Create Question'
    }.to change(Contribution, :count).by(1)
  end

end
