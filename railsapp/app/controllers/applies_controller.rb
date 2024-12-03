class AppliesController < ApplicationController
  before_action :set_apply, only: %i[ show edit update destroy ]

  # GET /applies or /applies.json
  def index
    @applies = Apply.includes(:department).all 
    @search = Apply.ransack(params[:q])
    @applies = @search.result.page(params[:page])

  end

  # GET /applies/1 or /applies/1.json
  def show
  end

  # GET /applies/new
  def new
    @apply = Apply.new
    @employee_user = current_user.login_user
    @employee_number = current_user.login_ref_no
    @preselected_department = Department.find_by(dep_name: current_user.login_department)
    @apply.build_division 
  end

  # GET /applies/1/edit
  def edit
  end

  # POST /applies or /applies.json
  def create
    @apply = Apply.new(apply_params)

    respond_to do |format|
      if @apply.save
        format.html { redirect_to @apply, notice: "Apply was successfully created." }
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

    # Only allow a list of trusted parameters through.
    def apply_params
      params.require(:apply).permit(:department_id, :add_dep_id, :apply_kind, :reference_no, :item_name, :apply_emp_no, :apply_emp_name, :apply_status, :tech_status, :tech_check_name, :approve_status, :equipment_name, :manufacturer_name, :supplier_name, :quantity, :estimated_cost, :location, :desired_delivery, :category, :reason, :specific_contents, :old_asset_no, :old_asset_multi, :old_asset_YM, :old_asset_handling, :wg_comment, :wg_comment_status, :wg_reply_comment, :sk_approve_cost, :sk_comment, division_attributes: [:id, :new_pur, :replace, :repair, :oh])
    end
end
