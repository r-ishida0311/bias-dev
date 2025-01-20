class StatusMailer < ApplicationMailer
  default from: "bias-dev@mbs.co.jp"
  def send_update_notification(apply)
    @apply = apply
    mail(
      to: 'r-ishida@mbs.co.jp', 
      subject: 'Application Updated'
      ) do |format|
    format.html { render 'send_update_notification' } #テンプレートを指定する
  end
  end
end
