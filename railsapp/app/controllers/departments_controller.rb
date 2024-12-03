class DepartmentsController < ApplicationController
  def index
    @years = Year.all
    @selected_year = params[:year] 
  end

  def import
    # fileはtmpに自動で一時保存される
    Department.import(params[:file])
    redirect_to departments_url
  end



end
