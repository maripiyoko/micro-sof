# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :text(65535)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sum_votes  :integer          default(0)
#

class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_one :approved_answer, class_name: "Answer", foreign_key: "id", primary_key: "approved_answer_id"
  has_many :votes, as: :votable
  has_many :comments, as: :commentable

  validates :title, presence: true
  validates :body, presence: true
  validates :user, presence: true

  acts_as_taggable

  BODY_SUMMARY_LENGTH = 50

  def summary
    if body && body.size > BODY_SUMMARY_LENGTH
      body.slice(0..BODY_SUMMARY_LENGTH) + '..'
    end
  end

  def created_by?(user)
    return false unless user
    self.user.id == user.id
  end

  def has_approved_answer?
    !self.approved_answer_id.nil?
  end

  def unapproved_answers
    id_to_exclude = self.approved_answer_id
    self.answers.where{id.not_eq id_to_exclude}
  end

  def self.unanswered_questions
    self.includes(:answers).where(answers: { id: nil })
  end

end
