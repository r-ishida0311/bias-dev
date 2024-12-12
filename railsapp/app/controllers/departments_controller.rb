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
        flash[:alert] = "Invalid year selected." # Handle the case where the year is not found
        redirect_to departments_path and return
      end

      Department.where(year_id: selected_year_id).destroy_all
      CSV.foreach(upload_file.path, headers: true, encoding: 'cp932') do |row|
        departments = Department.new(convert_csv_to_hash(row).merge(year_id: selected_year_id))
        if !departments.save
            flash[:alert] = "Error saving department: #{departments.errors.full_messages.join(', ')}" #Add error handling
        end
      end
      redirect_to departments_path, notice: "Departments imported successfully!"
    else
      flash[:alert] = "Please select a year and upload a file."
      redirect_to departments_path
    end
  end

  private

  def convert_csv_to_hash(row)
    { dep_name: row['部署名'] } #Add other attributes as needed
  end
end
