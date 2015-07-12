class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parent
  before_action :set_comment, only: [ :update, :destroy ]

  def create
    @comment = @parent.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.json status: :ok
      else
        format.json { render json: 'Cannot create comment', status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.json status: :ok
      else
        format.json status: :unprocessable_entity
      end
    end

  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.json status: :ok
    end
  end

  private

    def set_parent
      if params[:answer_id]
        @parent= Answer.find(params[:answer_id])
      else
        @parent = Question.find(params[:question_id])
      end

    end

    def set_comment
        @comment = @parent.comments.where(user_id: current_user.id).find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end

end
