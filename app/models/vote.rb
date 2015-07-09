class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :user, presence: true
  validates :user_id, uniqueness: { scope: [ :votable_id, :votable_type ] }
  validates :score, inclusion: { in: -1..1 }
end
