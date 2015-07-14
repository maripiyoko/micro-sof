# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  body             :text(65535)
#  user_id          :integer
#  commentable_id   :integer
#  commentable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :user, presence: true
  validates :commentable, presence: true
  validates :body, presence: true

  def created_by?(user)
    return false unless user
    self.user.id == user.id
  end
end
