# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions
  has_many :badges, -> { uniq }, through: :contributions
  has_many :contributions

  def has_badge?(badge_id)
    !self.contributions.find_by_badge_id(badge_id).nil?
  end

  def grant_student_badge
    if self.questions.any?
      badge = Badge.find(Constants::BADGE_STUDENT)
      self.badges << badge
    end
  end

  def grant_teacher_badge
    if self.answers.any?
      badge = Badge.find(Constants::BADGE_TEACHER)
      self.badges << badge
    end
  end

  def grant_regular_member_badge
    if self.questions.count + self.answers.count > 10
      badge = Badge.find(Constants::BADGE_REGULAR_MEMBER)
      self.badges << badge
    end
  end
end
