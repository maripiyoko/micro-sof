# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  body        :text(65535)
#  user_id     :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  sum_votes   :integer          default(0)
#

class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :votes, as: :votable

  validates :user, presence: true
  validates :question, presence: true

  def created_by?(user)
    return false unless user
    self.user.id == user.id
  end
end
