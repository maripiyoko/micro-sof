# == Schema Information
#
# Table name: badges
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  color       :string(255)
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Badge < ActiveRecord::Base
  has_many :users, through: :contributions
  has_many :contributions

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :color, presence: true
end
