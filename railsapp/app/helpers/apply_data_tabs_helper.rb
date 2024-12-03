module ApplyDataTabsHelper


  def translate_apply_kind(apply_kind)
    case apply_kind
    when "kind1"
      "申請種別1"
    when "kind2"
      "申請種別2"
    else
      "その他の申請種別"
    end
  end


  def translate_divisions(division)
    case division
    when "division1"
      "区分1"
    when "division2"
      "区分2"
    else
      "その他の区分"
    end
  end

  def translate_append_file_status(status)
    case status.to_i
      when 0 then "添付無し"
      when 1 then "作業中"
      when 2 then "完了"
      else "不明"
    end
  end

  def format_boss_check_statuses(apply_data_tab)
    (1..4).map do |i|
      name = apply_data_tab["boss_check_#{i}_name"] || "確認者無し"
      status = translate_boss_check(apply_data_tab["boss_check_#{i}"])
      "#{name}, #{status}"
    end.join(' / ')
  end

  def translate_boss_check(status)
    case status
      when 0 then "確認未"
      when 1 then "確認済"
      when 9 then "確認者なし"
      else status.to_s # Handle unexpected values
    end
  end

  def translate_apply_status(status)
    case status.to_i # Ensure status is an integer
      when 0 then "作業中"
      when 1 then "作業完了"
      when 2 then "申請"
      when 9 then "削除"
      else "不明" # Handle unexpected values gracefully
    end
  end

  def translate_tech_status(status)
    case status.to_i
      when 0 then "未確認"
      when 1 then "確認済"
      else "不明" # Handle unexpected values
    end
  end

end
