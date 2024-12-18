class ApplyFilesController < ApplicationController
  def destroy
    @apply = Apply.find(params[:apply_id])
    @file = @apply.files.find(params[:id])
    @file.purge
    redirect_to @apply, notice: 'ファイルが削除されました。'
  end
end

