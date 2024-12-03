module ApplyDataTabsHelper
  def translate_boss_check(status)
    case status
      when 0 then "確認未"
      when 1 then "確認済"
      when 9 then "確認者なし"
      else status.to_s # Handle unexpected values
    end
  end

end
