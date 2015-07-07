class Question < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  validates :user, presence: true

  def created_by?(user)
    return false unless user
    self.user.id == user.id
  end
end
