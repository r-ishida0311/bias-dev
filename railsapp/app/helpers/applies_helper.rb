module AppliesHelper
  def apply_kind_label(kind)
    case kind
    when 1
      "一般"
    when 2
      "放送"
    else
      "不明" # Or handle other cases as needed
    end
  end

  def display_oh(oh_value)
    oh_value == 1 ? "OH" : ""
  end

  def tech_status_label(status)
    case status
    when 0
      "未確認"
    when 1
      "確認済み"
    else
      "不明" # statusが0,1以外の値の場合の処理も追加
    end
  end

  def approve_status_label(status)
    case status
    when 0
      "未承認"
    when 1
      "A案件"
    when 2
      "B案件"
    when 9
      "否認"
    else
      "不明"
    end
  end

  def apply_status_label(status)
    case status
    when 0
      "作業中"
    when 1
      "作業完了"
    else
      "不明"
    end
  end

end
