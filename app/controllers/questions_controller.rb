class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_own_question, only: [:edit, :update, :destroy]

  def index
    @questions = Question.order(updated_at: :desc).page(params[:page])
  end

  def show
    @answer = Answer.new
    @answer.question_id = @question.id
    @answer.user = current_user
  end

  def new
    @question = current_user.questions.build
  end

  def edit
  end

  def create
    @question = current_user.questions.build(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: '新しい質問が投稿されました。' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: '質問を更新しました。' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: '質問を削除しました。' }
      format.json { head :no_content }
    end
  end

  private

    def set_question
      @question = Question.find(params[:id])
    end

    def set_own_question
      if @question.created_by?(current_user)
        @question = current_user.questions.find(params[:id])
      else
        redirect_to questions_url, alert: '他の人の質問は操作できません。'
      end
    end

    def question_params
      params.require(:question).permit(:title, :body)
    end
end
