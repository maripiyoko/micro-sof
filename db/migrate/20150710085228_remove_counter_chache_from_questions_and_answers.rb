class RemoveCounterChacheFromQuestionsAndAnswers < ActiveRecord::Migration
  def change
    remove_column :questions, :votes_count
    remove_column :answers, :votes_count
  end
end
