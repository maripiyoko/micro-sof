class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  validates :user, presence: true
  validates :question, presence: true

  def created_by?(user)
    return false unless user
    self.user.id == user.id
  end
end
