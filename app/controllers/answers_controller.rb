class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question
  before_action :set_own_question, only: [ :approve ]
  before_action :set_answer, only: [ :update, :destroy ]
  after_action :grant_badge, only: [ :create ]

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    if @answer.save
      redirect_to @question, notice: '回答が追加されました。'
    else
      redirect_to @question, alert: '回答が追加できませんでした。'
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @question, notice: '回答を更新しました。'
    else
      redirect_to @question, alert: '回答が更新できませんでした。'
    end
  end

  def approve
    @question.approved_answer_id = params[:id]
    if @question.save
      redirect_to @question, notice: '回答を承認しました。'
    else
      redirect_to @question, alert: '回答を承認できませんでした。'
    end
  end

  def destroy
    @answer.destroy
    redirect_to @question, notice: '回答を削除しました。'
  end

  private

    def set_question
      @question = Question.find(params[:question_id])
    end

    def set_own_question
      set_my_question(params[:question_id])
    end

    def set_answer
      @answer = @question.answers.find(params[:id])
      unless (@answer.created_by?(current_user))
        redirect_to @question, alert: '自分の回答ではないので、操作できません。'
      end
    end

    def answer_params
      params.require(:answer).permit(:body)
    end

    def grant_badge
      current_user.grant_teacher_badge
    end
end
