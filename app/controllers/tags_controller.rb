class TagsController < ApplicationController
  before_action :set_tag, only: [ :show ]

  def index
    @tags = ActsAsTaggableOn::Tag.most_used
  end

  def show
    @tagged_questions = Question.tagged_with(@tag.name).order(:updated_at)
  end

  private

    def set_tag
      @tag = ActsAsTaggableOn::Tag.find(params[:id])
    end
end
