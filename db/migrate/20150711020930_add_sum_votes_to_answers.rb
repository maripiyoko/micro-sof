class AddSumVotesToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :sum_votes, :integer, default: 0
    add_column :questions, :sum_votes, :integer, default: 0
  end
end
