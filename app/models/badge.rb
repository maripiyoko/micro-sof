class Badge < ActiveRecord::Base
  has_many :users, through: :contributions
  has_many :contributions

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :color, presence: true
end
