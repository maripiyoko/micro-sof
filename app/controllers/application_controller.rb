class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def set_my_question(question_id)
      if @question.created_by?(current_user)
        @question = current_user.questions.find(question_id)
      else
        redirect_to questions_url, alert: '他の人の質問は操作できません。'
      end
    end

end
