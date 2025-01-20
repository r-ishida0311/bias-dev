class StatusMailer < ApplicationMailer
  default from: "bias-dev@mbs.co.jp"

  def send_tech_comment_notification(apply)

    @apply = apply
    mail(to: @apply.emp_email, subject: '技術計画推進部コメントが更新されました') do |format|
      format.html { render 'send_tech_comment_notification' }
    end
  end

  def send_tech_reply_comment_notification(apply)

    @apply = apply
    tech_admin_users = AdminUser.where(tech_flag: 1)
    to_emails = tech_admin_users.pluck(:emp_admin_email)

    mail(to: to_emails, subject: ' 回答コメントが更新されました') do |format|
      format.html { render 'send_tech_comment_notification' }
    end
  end


end
