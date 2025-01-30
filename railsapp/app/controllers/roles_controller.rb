class RolesController < ApplicationController
  def new
    @department = Department.find(params[:department_id])
    @role = @department.roles.build
  end

  def create
    @department = Department.find(params[:department_id])
    @role = @department.roles.build(role_params)

    if @role.save
      # redirect_to edit_department_path(@department), notice: "Role was successfully created."
      render turbo_stream: turbo_stream.replace(
        "department_#{@department.id}",
        partial: "departments/department", locals: { department: @department }
      )
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def role_params
    params.require(:role).permit(:role) # Adjust permitted parameters as needed
  end
end
