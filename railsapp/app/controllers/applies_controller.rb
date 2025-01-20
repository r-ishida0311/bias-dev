class AppliesController < ApplicationController
  before_action :set_apply, only: [ :show, :edit, :update, :destroy ]
  before_action :set_employee_data, only: [:edit, :update]
  before_action :check_wg_access, only: [:edit], if: :wg_link_param?
  before_action :check_tech_access, only: [:edit], if: :tech_link_param?
  before_action :check_boss_access, only: [:edit], if: :boss_link_param?
  before_action :check_edit_access, only: [:edit], if: :edit_link_param?

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
    @employee_email = current_user.login_email
    @preselected_year = Year.find_by(target_year: 1)&.year
    @departments = Department.where(year_id: Year.find_by(year: @preselected_year)&.id).all
    @preselected_department = @departments.find_by(dep_name: current_user.login_department)
  end

  # GET /applies/1/edit
  def edit
    @apply = Apply.includes(:boss1).find(params[:id]) 
    @preselected_year = Year.find_by(target_year: 1)&.year
    @departments = Department.where(year_id: Year.find_by(year: @preselected_year)&.id).all
    
  end

  def check_wg_access
    unless AdminUser.exists?(emp_no: current_user.login_ref_no.to_i, wg_flag: 1)
      redirect_to root_path, notice: 'アクセス権限がありません。'
    end
  end

  def wg_link_param?
    params[:link_param1] == 'wg'
  end

  def check_tech_access
    unless AdminUser.exists?(emp_no: current_user.login_ref_no.to_i, tech_flag: 1)
      redirect_to root_path, notice: 'アクセス権限がありません。'
    end
  end

  def tech_link_param?
    params[:link_param1] == 'tech'
  end

  def check_boss_access
    unless current_user.login_ref_no.to_i == @apply.boss1.boss_no.to_i
      redirect_to root_path, notice: 'アクセス権限がありません。'
    end
  end

  def boss_link_param?
    params[:link_param1] == 'boss'
  end

  def check_edit_access
    unless current_user.login_ref_no.to_i == @apply.apply_emp_no.to_i
      redirect_to root_path, notice: 'アクセス権限がありません。'
    end
  end

  def edit_link_param?
    params[:link_param1] == 'edit'
  end
  # POST /applies or /applies.json
  def create
    @apply = Apply.new(apply_params)
    @employee_user = current_user.login_user
    @employee_number = current_user.login_ref_no
    @employee_email = current_user.login_email
    @preselected_department = Department.find_by(dep_name: current_user.login_department)
    @preselected_year = Year.find_by(target_year: 1)&.year
    @departments = Department.where(year_id: Year.find_by(year: @preselected_year)&.id).all
    respond_to do |format|
      if @apply.save
        BossMailer.with(infomail: @admin_user).send_mail.deliver_later 
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

    @preselected_year = Year.find_by(target_year: 1)&.year
    @departments = Department.all
    respond_to do |format|
      if @apply.update(apply_params)
        StatusMailer.send_update_notification(@apply).deliver_now
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
      @employee_email = @apply.emp_email
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
    :emp_email,
    files: [],
    boss1_attributes: [:id, :boss_no, :boss_name, :boss_status, :boss_email, :boss_depart],
    division_attributes: [:id, :new_pur, :replace, :repair, :_destroy],
    apply_status_attributes: [:id, :apply_status, :_destroy],
    sk_comment_attributes: [:id, :sk_comment, :sk_user, :_destroy],
    tech_comment_attributes: [:id, :tech_comment, :tech_user, :_destroy],
    tech_reply_comment_attributes: [:id, :tech_reply_comment,  :_destroy],
    tech_status_attributes: [:id, :tech_check_name, :tech_status, :_destroy],
    approve_status_attributes: [:id, :approve_status, :_destroy]
  ).tap do |permitted|
    permitted.delete(:files) if params[:files].blank? 
  end
end

end
