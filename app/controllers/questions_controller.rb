class QuestionsController < ApplicationController
  include BadgeContributions

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_own_question, only: [:edit, :update, :destroy]
  after_action :grant_student_badge, only: [:create]
  after_action :grant_regular_member_badge, only: [:create]

  def index
    if params[:sort] == "unanswered"
      questions = Question.unanswered_questions
    else
      questions = Question.all
    end
    @questions = questions.order(updated_at: :desc).page(params[:page])
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
      set_my_question(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :body, :tag_list)
    end

end
