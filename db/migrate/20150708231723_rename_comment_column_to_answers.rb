class RenameCommentColumnToAnswers < ActiveRecord::Migration
  def change
    rename_column :answers, :comment, :body
  end
end
