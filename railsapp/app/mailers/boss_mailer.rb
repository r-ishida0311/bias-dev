class BossMailer < ApplicationMailer
  def send_mail(apply) # Applyオブジェクトを受け取る
    @apply = apply # インスタンス変数に代入
    mail(
      from: 'bias@mbs.co.jp',
      to:   'r-ishida@mbs.co.jp',
      subject: 'biasTESTmail - 新しい申請があります' #件名も分かりやすく変更
    ) do |format|
      format.text { render 'apply_notification' } #テンプレートを指定する
    end
  end
end
