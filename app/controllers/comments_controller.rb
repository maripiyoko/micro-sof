class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parent
  before_action :set_comment, only: [ :edit, :show, :update, :destroy ]
  before_action :set_comments, only: [ :create, :update, :destroy ]

  def new
    @comment = Comment.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js { render :new }
    end
  end

  def create
    @comment = @parent.comments.build(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html do
          if @answer.nil?
            redirect_to @question
          else
            redirect_to @answer
          end
        end
        format.js
      else
        format.js { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.js { render :create }
      else
        format.js { render :edit }
      end
    end

  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  private

    def set_parent
      @question = Question.find(params[:question_id])
      if params[:answer_id]
        @answer= Answer.find(params[:answer_id])
        @parent = @answer
      else
        @parent = @question
      end
    end

    def set_comment
      @comment = @parent.comments.where(user_id: current_user.id).find(params[:id])
    end

    def set_comments
      @comments = @parent.comments
    end

    def comment_params
      params.require(:comment).permit(:body)
    end

end
