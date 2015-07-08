class AnswersController < ApplicationController
  before_action :set_question
  before_action :set_answer, only: [ :update, :destroy ]

  def create
  end

  def update

  end

  def destroy

  end

  private

    def set_question
      @question = Questions.find(params[:question_id])
    end

    def set_answer
      @answer = @question.find(params[:id])
      unless (@answer.created_by?(current_user))
        redirect_to @question, alert: '自分の回答ではありません。操作できません。'
      end
    end

end
