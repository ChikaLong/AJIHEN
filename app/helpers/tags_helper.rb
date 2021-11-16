module TagsHelper
  def btn_text
    if action_name == "new"
      "新規追加"
    elsif action_name == "edit"
      "更新"
    end
  end
end
