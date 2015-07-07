class Question < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  validates :user, presence: true

  BODY_SUMMARY_LENGTH = 50

  def summary
    if self.body && self.body.size > BODY_SUMMARY_LENGTH
      self.body.slice(0..BODY_SUMMARY_LENGTH) + ".."
    end
  end

  def created_by?(user)
    return false unless user
    self.user.id == user.id
  end
end
