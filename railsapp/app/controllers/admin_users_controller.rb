class AdminUsersController < ApplicationController
  def index
    @admin_users = AdminUser.all
  end

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(cat_params)

    if @admin_user.save
      flash.now.notice = "登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @admin_user.update(admin_user_params)
      flash.now.notice = "更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
        @admin_user.destroy
    flash.now.notice = "ねこを削除しました。"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @admin_user = AdminUser.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_user_params
      params.require(:admin_user).permit(:emp_no, :emp_no, :tech_flag, :wg_flag, :sys_flag)
    end


end
