module PostsHelper
  def button_text
    if action_name == "new"
      "投稿"
    elsif action_name == "edit"
      "更新"
    end
  end
end
