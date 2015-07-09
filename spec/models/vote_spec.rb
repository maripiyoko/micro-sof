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

require 'rails_helper'

RSpec.describe Vote, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
