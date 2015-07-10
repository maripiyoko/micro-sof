module Votable
  extend ActiveSupport::Concern

  def sum_votes
    self.votes.sum(:score)
  end

end
