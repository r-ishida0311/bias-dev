class ApplyDataTabsController < ApplicationController
  before_action :set_apply_data_tab, only: %i[ show edit update destroy ]

  # GET /apply_data_tabs or /apply_data_tabs.json
  def index

    @search = ApplyDataTab.ransack(params[:q])
    @apply_data_tabs = @search.result.where.not(apply_status: 9).page(params[:page])
    @years = ApplyDataTab.select(:year).distinct.pluck(:year).map { |year| [year, year] }
  end

  # GET /apply_data_tabs/1 or /apply_data_tabs/1.json
  def show
    @apply_data_tab = ApplyDataTab.find(params[:id])
    @files = @apply_data_tab.FilesTab #Loads associated FilesTab records
  end

  def all_departments_by_year
    year = params[:year]
    departments_by_year = ApplyDataTab.where(year: year).pluck(:apply_emp_dep).uniq
    sorted_departments = departments_by_year.sort_by { |department| department.to_s }
    render json: sorted_departments
  end
  

  # GET /apply_data_tabs/new
  def new
    @apply_data_tab = ApplyDataTab.new
  end

  # GET /apply_data_tabs/1/edit
  def edit
  end

  # POST /apply_data_tabs or /apply_data_tabs.json
  def create
    @apply_data_tab = ApplyDataTab.new(apply_data_tab_params)

    respond_to do |format|
      if @apply_data_tab.save
        format.html { redirect_to @apply_data_tab, notice: "Apply data tab was successfully created." }
        format.json { render :show, status: :created, location: @apply_data_tab }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @apply_data_tab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apply_data_tabs/1 or /apply_data_tabs/1.json
  def update
    respond_to do |format|
      if @apply_data_tab.update(apply_data_tab_params)
        format.html { redirect_to @apply_data_tab, notice: "Apply data tab was successfully updated." }
        format.json { render :show, status: :ok, location: @apply_data_tab }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @apply_data_tab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apply_data_tabs/1 or /apply_data_tabs/1.json
  def destroy
    @apply_data_tab.destroy!

    respond_to do |format|
      format.html { redirect_to apply_data_tabs_path, status: :see_other, notice: "Apply data tab was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apply_data_tab
      @apply_data_tab = ApplyDataTab.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def apply_data_tab_params
      params.fetch(:apply_data_tab, {})
    end
end
