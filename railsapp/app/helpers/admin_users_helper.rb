module AdminUsersHelper
  def flag(flag)
    case flag
    when 0
      "✕"
    when 1
      "〇"
    else
      "不明" # Or handle other cases as needed
    end
  end
end
