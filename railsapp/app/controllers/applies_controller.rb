class AppliesController < ApplicationController
  before_action :set_apply, only: %i[ show edit update destroy ]
  before_action :set_employee_data, only: [:edit, :update]
  # GET /applies or /applies.json
  def index
    @applies = Apply.includes(:department).all 
    @search = Apply.ransack(params[:q])
    @applies = @search.result.page(params[:page])

  end

  # GET /applies/1 or /applies/1.json
  def show
    @apply = Apply.find(params[:id])
    @readonly = true # Add this line
  end

  # GET /applies/new
  def new
    @apply = Apply.new(apply_kind: 1) 
    @employee_user = current_user.login_user
    @employee_number = current_user.login_ref_no
    @preselected_department = Department.find_by(dep_name: current_user.login_department)
    @apply.build_division 
    @preselected_year = Year.find_by(target_year: 1)&.year
  end

  # GET /applies/1/edit
  def edit
    @preselected_year = Year.find_by(target_year: 1)&.year
  end

  # POST /applies or /applies.json
  def create
    @apply = Apply.new(apply_params)

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
    respond_to do |format|
      if @apply.update(apply_params)
        format.html { redirect_to @apply, notice: "Apply was successfully updated." }
        format.json { render :show, status: :ok, location: @apply }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @apply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applies/1 or /applies/1.json
  def destroy
    @apply.destroy!

    respond_to do |format|
      format.html { redirect_to applies_path, status: :see_other, notice: "Apply was successfully destroyed." }
      format.json { head :no_content }
    end
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

    # Only allow a list of trusted parameters through.
def apply_params
  params.require(:apply).permit(:apply_emp_no, 
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
:apply_status, 
:tech_status, 
:approve_status,
:wg_comment_status, 
:wg_comment,
:wg_reply_comment,
:year, 
:sk_approve_cost,
:sk_comment,
files: [], 
boss1_attributes: [:id, :boss_no, :boss_name, :boss_status, :boss_email, :boss_depart], 
division_attributes: [:id, :new_pur, :replace, :repair, :_destroy])
end
end
