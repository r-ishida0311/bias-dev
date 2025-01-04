class AdminUsersController < ApplicationController
  def index
    @admin_users = AdminUser.all
  end

  def new
    @admin_users = AdminUser.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
