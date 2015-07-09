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
#

class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers

  validates :title, presence: true
  validates :body, presence: true
  validates :user, presence: true

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
end
