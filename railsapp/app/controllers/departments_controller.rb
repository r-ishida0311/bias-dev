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

def show
  @department = Department.find(params[:id])
end


  def new
    @year_id = params[:year_id] # Retrieve year_id from params
    @department = Department.new(year_id: @year_id) #
    @department.roles.build # pre-build a role to handle at least one role.
    render layout: false  #Optional: Use this for a modal or a partial
  end


  def edit
    @department = Department.find(params[:id])
    @department.roles.build if @department.roles.empty? 
  end

  def update
    @department = Department.find(params[:id])
    if @department.update(department_params)
      @department.roles.where(role: [nil, ""]).destroy_all
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @department = Department.find(params[:id])
    @department.destroy


  end

  def roles
    department = Department.find(params[:id])
    render json: department.roles
  end


  def create

  if params[:upload_file].present? && params[:year].present?
    upload_file = params[:upload_file].tempfile
    selected_year_id = Year.find_by(year: params[:year])&.id

    if selected_year_id.nil?
      flash[:alert] = "Invalid year selected."
      redirect_to departments_path and return
    end

    # Delete existing data for the selected year
    Apply.where(department_id: Department.where(year_id: selected_year_id).pluck(:id)).destroy_all
    Department.where(year_id: selected_year_id).destroy_all
    Role.where(department_id: Department.where(year_id: selected_year_id).pluck(:id)).destroy_all


    CSV.foreach(upload_file.path, headers: true, encoding: 'cp932') do |row|
      # Create the department
      department = Department.new(dep_name: row['部署名'], year_id: selected_year_id)
      unless department.save
        flash[:alert] = "Error saving department: #{department.errors.full_messages.join(', ')}"
        redirect_to departments_path and return # Stop processing if department save fails
      end

      role_columns = row.headers.select { |header| header.start_with?('担当') }
      role_columns.each do |role_column|
        if row[role_column].present?
          role = Role.new(role: row[role_column], department_id: department.id)
          unless role.save
            flash[:alert] = "Error saving role: #{role.errors.full_messages.join(', ')}"
            redirect_to departments_path and return # Stop processing if role save fails
          end
        end
      end
    end
    redirect_to departments_path, notice: "Departments and roles imported successfully!"
  else
    year = Year.find_by(year: params[:department][:year_id])
    if year.nil?
      flash[:alert] = "Invalid year selected."
      redirect_to departments_path and return
    end
  
    @department = Department.new(department_params.merge(year_id: year.id))

    if @department.save
      redirect_to departments_path, notice: "Department was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end
end


# app/controllers/departments_controller.rb
def export_csv
  @selected_year = params[:year]
  if @selected_year.present?
    @departments = Department.where(year_id: Year.find_by(year: @selected_year)&.id).all
    if @departments.any?
      response.headers['Content-Type'] = 'text/csv; charset=shift_jis'
      response.headers['Content-Disposition'] = "attachment; filename=#{@selected_year}年度部署一覧.csv"
      
      # ヘッダーを動的に生成
      max_roles = @departments.map { |department| department.roles.count }.max
      header = ['部署名'] + (1..max_roles).map { |i| "担当#{i}" }
      
      csv_data = CSV.generate(headers: true, force_quotes: true) do |csv|
        csv << header

        @departments.each do |department|
          roles = department.roles.map(&:role)
          row = [department.dep_name] + roles
          csv << row
        end
      end

      self.response_body = csv_data.encode(Encoding::SJIS, invalid: :replace, undef: :replace)
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

  def department_params
    params.require(:department).permit(:dep_name, :year_id,  roles_attributes: [:id, :role, :_destroy])
  end


end
