# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  body        :text(65535)
#  user_id     :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  sum_votes   :integer          default(0)
#

require 'rails_helper'

RSpec.describe Answer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
