module BadgeContributions extend ActiveSupport::Concern

  def grant_student_badge
    current_user.grant_student_badge
  end

  def grant_teacher_badge
    current_user.grant_teacher_badge
  end

  def grant_regular_member_badge
    current_user.grant_regular_member_badge
  end

end
