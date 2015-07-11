class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_target

  def up
    @target.increment(:score)
    if @target.valid?
      @target.save!
      render json: @target.votable.sum_votes
    else
      render json: 'you are already voted.', status: :unprocessable_entity
    end
  end

  def down
    @target.decrement(:score)
    if @target.valid?
      @target.save!
      render json: @target.votable.sum_votes
    else
      render json: 'you are already voted.', status: :unprocessable_entity
    end

  end

  private

    def set_target
      if params[:question_id]
        # question_id がある場合、idはanswer
        answer = Answer.find(params[:id])
        @target = answer.votes.find_or_initialize_by(user_id: current_user.id)
      else
        question = Question.find(params[:id])
        @target = question.votes.find_or_initialize_by(user_id: current_user.id)
      end
    end

end
