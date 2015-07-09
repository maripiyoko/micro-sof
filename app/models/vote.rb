# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  votable_id   :integer
#  votable_type :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  score        :integer          default(0)
#

class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true, counter_cache: :votes_count

  validates :user, presence: true
  validates :user_id, uniqueness: { scope: [ :votable_id, :votable_type ] }
  validates :score, inclusion: { in: -1..1 }
end
