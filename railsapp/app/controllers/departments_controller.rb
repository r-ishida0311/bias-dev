class DepartmentsController < ApplicationController
  def index
    @years = Year.all
    @selected_year = params[:year]#default to the latest year if none selected

    if @selected_year.present?
      @departments = Department.where(year_id: Year.find_by(year: @selected_year)&.id).all
    else
      @departments = [] # Or handle the case where no year is selected appropriately.
    end
  end




  
def create
  if params[:upload_file].present? && params[:year].present?
    upload_file = params[:upload_file].tempfile
    selected_year_id = Year.find_by(year: params[:year])&.id

    if selected_year_id.nil?
      flash[:alert] = "Invalid year selected."
      redirect_to departments_path and return
    end

    Apply.where(department_id: Department.where(year_id: selected_year_id).pluck(:id)).destroy_all
    Department.where(year_id: selected_year_id).destroy_all

    CSV.foreach(upload_file.path, headers: true, encoding: 'cp932') do |row|
      department = Department.new(dep_name: row['部署名'], role1: row['担当1'], year_id: selected_year_id)
      if !department.save
        flash[:alert] = "Error saving department: #{departments.errors.full_messages.join(', ')}" #Add error handling
      end

  end
    redirect_to departments_path, notice: "Departments and roles imported successfully!"
  else
    flash[:alert] = "Please select a year and upload a file."
    redirect_to departments_path
  end
end


  def export_csv
    @selected_year = params[:year]
    if @selected_year.present?
      @departments = Department.where(year_id: Year.find_by(year: @selected_year)&.id).all
      if @departments.any?
        response.headers['Content-Type'] = 'text/csv; charset=shift_jis'
        response.headers['Content-Disposition'] = "attachment; filename=#{@selected_year}年度部署一覧.csv"
        self.response_body = generate_csv(@departments) # ストリーミングレスポンス
      else
        flash[:alert] = "選択された年度の部署データはありません。"
        redirect_to departments_path
      end
    else
      flash[:alert] = "年度を選択してください。"
      redirect_to departments_path
    end
  end


  private

  def convert_csv_to_hash(row)
    { dep_name: row['部署名'] } #Add other attributes as needed
  end

  def generate_csv(departments)
    Enumerator.new do |yielder|
      yielder << CSV.generate_line(["部署名"], force_quotes: true, encoding: 'SJIS') # ヘッダー
      departments.find_each do |department|
        yielder << CSV.generate_line([department.dep_name], force_quotes: true, encoding: 'SJIS')
      end
    end
  end

end
