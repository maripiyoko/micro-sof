module CommentsHelper

  def comments_path_new(question, answer)
    if answer.nil?
      new_polymorphic_path([question, :comment])
    else
      new_polymorphic_path([question, answer, :comment])
    end
  end

  def comments_path_edit(question, answer, comment)
    if answer.nil?
      edit_polymorphic_path([question, comment])
    else
      edit_polymorphic_path([question, answer, comment])
    end
  end

  def comments_path(question, answer, comment)
    if answer.nil?
      polymorphic_path([question, comment])
    else
      polymorphic_path([question, answer, comment])
    end
  end
end
