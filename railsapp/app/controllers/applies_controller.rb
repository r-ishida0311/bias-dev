class AppliesController < ApplicationController
  before_action :set_apply, only: [ :show, :edit, :update, :destroy ]
  before_action :set_employee_data, only: [:edit, :update]
  # GET /applies or /applies.json
  def index
    @applies = Apply.includes(:department).all 
    @search = Apply.ransack(params[:q])
    @applies = @search.result.page(params[:page])
    @years = Year.all.map(&:year) 
  end

  # GET /applies/1 or /applies/1.json
  def show
    @apply = Apply.find(params[:id])
    @departments = Department.all # Or your appropriate query
    @preselected_department = @apply.department 
   

    render :show
  end

  # GET /applies/new
  def new
    @apply = Apply.new(apply_kind: 1) 
    
    @employee_user = current_user.login_user
    @employee_number = current_user.login_ref_no
    @apply.build_division 
    @preselected_year = Year.find_by(target_year: 1)&.year
    @departments = Department.where(year_id: Year.find_by(year: @preselected_year)&.id).all
    @preselected_department = @departments.find_by(dep_name: current_user.login_department)
  end

  # GET /applies/1/edit
  def edit
    @preselected_year = Year.find_by(target_year: 1)&.year
    @departments = Department.where(year_id: Year.find_by(year: @preselected_year)&.id).all
    
  end

  # POST /applies or /applies.json
  def create
    @apply = Apply.new(apply_params)
    @employee_user = current_user.login_user
    @employee_number = current_user.login_ref_no
    @preselected_department = Department.find_by(dep_name: current_user.login_department)
    @preselected_year = Year.find_by(target_year: 1)&.year
    respond_to do |format|
      if @apply.save
        format.html { redirect_to applies_path, notice: "Apply was successfully created." }
        format.json { render :show, status: :created, location: @apply }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @apply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applies/1 or /applies/1.json
  def update
   
    @apply = Apply.find(params[:id])
    @employee_user = current_user.login_user
    @employee_number = current_user.login_ref_no
    @preselected_department = @apply.department
    @preselected_year = Year.find_by(target_year: 1)&.year
    @departments = Department.all
    respond_to do |format|
      if @apply.update(apply_params)
        format.html { redirect_to applies_path, notice: "Apply was successfully updated." }
        format.json { render :show, status: :ok, location: @apply }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @apply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applies/1 or /applies/1.json
def destroy
  @apply.destroy

  respond_to do |format|
    format.html { redirect_to applies_path, notice: "Apply was successfully destroyed." }
    format.json { head :no_content }
  end
end

def departments_by_year
  year = params[:year]
  year_record = Year.find_by(year: year) # Find the Year record by its 'year' attribute

  if year_record
    departments_by_year = year_record.departments.pluck(:dep_name) # Efficiently get dep_names from associated departments
    sorted_departments = departments_by_year.sort
    render json: sorted_departments
  else
    render json: { error: "Year not found" }, status: 404
  end
end




def upload_file
  Rails.logger.info "upload_file action called with params: #{params.inspect}"

  apply = Apply.find(params[:apply_id])
  file_blob = create_blob(params[:file])

  apply.files.attach(file_blob)

  render json: { id: file_blob.id, url: url_for(file_blob), file_name: file_blob.filename.to_s }
end

def destroy_attachment
  Rails.logger.info "destroy attachement"
  @apply = Apply.find(params[:apply_id])
  @blob = ActiveStorage::Blob.find(params[:blob_id])
  @attachment = ActiveStorage::Attachment.find_by(record_type: 'Apply', record_id: @apply.id, blob_id: @blob.id)
  @attachment.purge
  head :no_content
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apply
      @apply = Apply.find(params[:id])
    end

    def set_employee_data #Add this method
      @employee_number = @apply.apply_emp_no # Or fetch it appropriately from your model
      @employee_user = @apply.apply_emp_name # Or fetch it appropriately from your model
      @preselected_department = @apply.department # Assuming you have a department association
    end

    def create_blob(file)
      ActiveStorage::Blob.create_and_upload!(
        io: file.open,
        filename: file.original_filename,
        content_type: file.content_type
      )
    end



    # Only allow a list of trusted parameters through.
def apply_params
  params.require(:apply).permit(
    :apply_emp_no,
    :apply_emp_name,
    :apply_kind,
    :department_id,
    :reference_no,
    :item_name,
    :equipment_name,
    :manufacturer_name,
    :supplier_name,
    :quantity,
    :estimated_cost,
    :desired_delivery,
    :location,
    :reason,
    :specific_contents,
    :old_asset_multi,
    :old_asset_no,
    :old_asset_YM,
    :old_asset_cost,
    :old_asset_handling,
    :tech_status,
    :approve_status,
    :wg_comment_status,
    :wg_comment,
    :wg_reply_comment,
    :year,
    :sk_approve_cost,
    :sk_comment,
    :apply_status_id,
    files: [],
    boss1_attributes: [:id, :boss_no, :boss_name, :boss_status, :boss_email, :boss_depart],
    division_attributes: [:id, :new_pur, :replace, :repair, :_destroy],
    apply_status_attributes: [:id, :apply_status, :_destroy]
  ).tap do |permitted|
    permitted.delete(:files) if params[:files].blank? # Delete files key entirely if blank
  end
end

end
