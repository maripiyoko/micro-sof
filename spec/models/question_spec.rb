# == Schema Information
#
# Table name: questions
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  body               :text(65535)
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  sum_votes          :integer          default(0)
#  approved_answer_id :integer
#

require 'rails_helper'

RSpec.describe Question, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
