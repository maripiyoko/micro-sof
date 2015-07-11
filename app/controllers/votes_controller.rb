class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vote

  def up
    @vote.increment(:score)
    if @vote.valid?
      @vote.save!
      render json: @vote.votable.sum_votes
    else
      render json: 'you are already voted.', status: :unprocessable_entity
    end
  end

  def down
    @vote.decrement(:score)
    if @vote.valid?
      @vote.save!
      render json: @vote.votable.sum_votes
    else
      render json: 'you are already voted.', status: :unprocessable_entity
    end

  end

  private

    def set_vote
      if params[:question_id]
        # question_id がある場合、idはanswer
        answer = Answer.find(params[:id])
        @vote = answer.votes.find_or_initialize_by(user_id: current_user.id)
      else
        question = Question.find(params[:id])
        @vote = question.votes.find_or_initialize_by(user_id: current_user.id)
      end
    end

end
