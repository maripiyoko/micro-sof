class AddApprovedAnswerColumnToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :approved_answer_id, :integer
    add_index :questions, :approved_answer_id
  end
end
