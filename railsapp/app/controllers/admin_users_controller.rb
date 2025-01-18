class AdminUsersController < ApplicationController
  before_action :set_admin_user, only: %i[ show edit update destroy ]


  def index
    
    @search = AdminUser.ransack(params[:q])

    # デフォルトのソートをid降順にする
    @search.sorts = 'id desc' if @search.sorts.empty?
 
    # `@search.result`で検索結果となる@catsを取得する
    # 検索結果に対してはkaminariのpageメソッドをチェーンできる
    @admin_users = @search.result.page(params[:page])
  end

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(admin_user_params)

    if @admin_user.save
      
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @admin_user.update(admin_user_params)
      
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
        @admin_user.destroy
   
  end





  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @admin_user = AdminUser.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_user_params
      params.require(:admin_user).permit(:emp_no, :emp_name, :tech_flag, :wg_flag, :sys_flag)
    end


end
